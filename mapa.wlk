import francella.*


// Objetos de mapa------------------------------------------------------------
//Aca va todo lo relacionado a objetos del mapa en si, como colisiones, freezer e intermediarios de interaccion entre francella y otros objetos.


object colisiones { //Objeto encargado de manejar las colisiones en el mapa
    const celdasConColision = #{} //Set de celdas que tienen colision

    method establecerNuevaColision(_position) {
        celdasConColision.add(_position)
    }

    method hayColisionEn(celda) {
        return celdasConColision.contains(celda)
    }
}

object freezer { //Establece las celdas a lo referente al freezer, que le quitara vida a francella si está mucho tiempo en ellas.
    const celdasDelFreezer = #{}
    const victima          = francella 

    method establecerNuevaCeldaDelFreezer(_position) {
        celdasDelFreezer.add(_position)
    }

    method estaVictimaEnCelda(celda) {
        return celda.position() == victima.position()
    }

    method estaVictimaEnElFreezer() {
        return celdasDelFreezer.any({celda => self.estaVictimaEnCelda(celda)})
    }

    method congelarAlVictimaSiEsta() {
        game.onTick(2500, "congelador", {
            if (self.estaVictimaEnElFreezer()) {
                victima.recibirDanio(1)
            }
        })
    }
}

class IntermediarioDeInteraccion { //Clase diseñada para los objetos intermediarios que permiten la interaccion entre francella y otros objetos, apareciendo como un circulo.
    const property position
    const receptorDeInteraccion

    method image() {
        return "intermediarioPH.gif"
    }

    method recibirColocar(item) {
        receptorDeInteraccion.recibirColocar(item)
    }

    method recibirAgarrar() {
        receptorDeInteraccion.recibirAgarrar()
    }
}

object intermediariosDeInteraccion {

    // Me asquea que se repita tanta lógica, pero no encontré una manera de generalizar estos métodos

    method objetoEn(_position) {
        return game.getObjectsIn(_position).uniqueElement()
    }

    method establecerNuevoIntermediarioHere(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(_position))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioDown(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x(), _position.y() + 1)))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioUp(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x(), _position.y() - 1)))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioLeft(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x() + 1, _position.y())))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioRight(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x() - 1, _position.y())))
        game.addVisual(nuevoIntermediario)
    }
}


// Mapa --------------------------------------------------------------------------------------------------------------------------------------------------------


object __{
    method dibujar(position) {

    }
}

object cc{

    method dibujar(position) {
        colisiones.establecerNuevaColision(position)
    }

}

object fr {
    
    method dibujar(position) {
        freezer.establecerNuevaCeldaDelFreezer(position)
    }
}

object ih {
    
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioHere(position)
    }
}

object id {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioDown(position)
    }
}

object iu {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioUp(position)
    }
}

object il {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioLeft(position)
    }
}

object ir {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioRight(position)
    }
}

object mapa {
    const dibujo =[
        [ __, __, __, __, __, cc, cc, cc, cc, cc, __, __, __, __, il, cc ],
        [ __, __, __, __, __, id, __, id, __, id, __, __, __, __, __, __ ],
        [ __, __, __, __, __, __, __, __, __, __, __, __, __, __, __, __ ],
        [ __, __, __, __, __, cc, __, cc, cc, cc, __, cc, cc, cc, __, cc ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, cc, __, cc ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, id, __, id ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, iu, __, iu ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, cc, cc, cc ]
    ].reverse()

    method dibujarMapa() {
        game.height(dibujo.size())
        game.width(dibujo.anyOne().size())
        (0 .. game.width() - 1).forEach({ x => 
            (0 .. game.height() - 1).forEach({y => 
                dibujo.get(y).get(x).dibujar(game.at(x,y))
            })
        })
    }
}