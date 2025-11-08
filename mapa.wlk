// Objetos de mapa ---------------------------------------------------------------------------------------------------------------------------------------------


object colisiones {
    const celdasConColision = #{}

    method establecerNuevaColision(_position) {
        celdasConColision.add(_position)
    }

    method hayColisionEn(celda) {
        return celdasConColision.contains(celda)
    }
}

class IntermediarioDeInteraccion {
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

    method establecerNuevoIntermediarioAbajo(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x(), _position.y() + 1)))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioSuperior(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x(), _position.y() - 1)))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioIzquierdo(_position) {
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(game.at(_position.x() + 1, _position.y())))
        game.addVisual(nuevoIntermediario)
    }

    method establecerNuevoIntermediarioDerecho(_position) {
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

object ia {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioAbajo(position)
    }
}

object is {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioSuperior(position)
    }
}

object ii {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioIzquierdo(position)
    }
}

object id {
  
    method dibujar(position) {
        intermediariosDeInteraccion.establecerNuevoIntermediarioDerecho(position)
    }
}

object mapa {
    const dibujo =[
        [ __, __, __, __, __, cc, cc, cc, __, __, __, __, __, __, ii, cc ],
        [ __, __, __, __, __, ia, ia, ia, __, __, __, __, __, __, __, __ ],
        [ __, __, __, __, __, __, __, __, __, __, __, __, __, __, __, __ ],
        [ __, __, __, __, __, cc, __, cc, cc, cc, __, cc, cc, cc, __, cc ],
        [ __, __, __, __, __, __, __, __, cc, __, __, __, cc, __, __, __ ],
        [ __, __, __, __, __, __, __, __, cc, __, __, __, cc, ia, __, ia ],
        [ __, __, __, __, __, __, __, __, cc, __, __, __, cc, is, __, is ],
        [ __, __, __, __, __, __, __, __, cc, __, __, __, cc, __, __, cc ]
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