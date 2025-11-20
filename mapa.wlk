import francella.*
import direcciones.*
import interfazVisual.*

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

// Intermediarios de interaccion -------------------------------------------------------------------
class IntermediarioDeInteraccion { //Clase diseñada crear instancias que sirvar para como medio para que francella interaccione con ellos. 
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



class FactoryIntermediarioInteraccion { //Clase que generaliza el proceso que hace cada factory para crear un intermediario de interacción

    method posicionEstablecida(_position) { //La posición establecida es un método hook que dependerá de cada factory en dónde colocar el intermediario
        return _position
    }

    method objetoEn(_position) { //Establece a qué objeto sirve el intermediador
        return game.getObjectsIn(self.posicionEstablecida(_position)).uniqueElement()
    }

    method establecerNuevoIntermediario(_position) { //Template method que generaliza la creación de intermediarios.
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(_position))
        game.addVisual(nuevoIntermediario)
    }
}


object factoryIntermediarioHere inherits FactoryIntermediarioInteraccion { //Factory de intermediadores que son medio de un objeto en la misma posicion que les fue dada

}

object factoryIntermediarioUp inherits FactoryIntermediarioInteraccion { //Factory que crea un intermediador que interacciona con un objeto que se encuentra arriba de la posición dada.

    override method posicionEstablecida(_position) {
        return arriba.siguiente(_position)
    }

}

object factoryIntermediarioDown inherits FactoryIntermediarioInteraccion { //Factory que crea un intermediador que interacciona con un objeto que se encuentra abajo de la posición dada.

    override method posicionEstablecida(_position) {
        return abajo.siguiente(_position)
    }

}

object factoryIntermediarioLeft inherits FactoryIntermediarioInteraccion { //Factory que crea un intermediador que interacciona con un objeto que se encuentra izquierda de la posición dada.

    override method posicionEstablecida(_position) {
        return izquierda.siguiente(_position)
    }

}



object factoryIntermediarioRight inherits FactoryIntermediarioInteraccion { //Factory que crea un intermediador que interacciona con un objeto que se encuentra derecha de la posición dada.

    override method posicionEstablecida(_position) {
        return derecha.siguiente(_position)
    }

}


// Mapa --------------------------------------------------------------------------------------------------------------------------------------------------------
//Cada posible objeto que pueda ser dibujado está representado por dos caracteres, y todos comparten la interfaz dibujon, que tiene el método dibujar(position), que dibuja el objeto en la posición dada.

class Dibujo { //Interfaz que comparten todos los objetos dibujables en el mapa
    method dibujar(position) {

    }
}

object __ inherits Dibujo { //Representa un espacio vacío en el mapa

}

object cc inherits Dibujo { //Representa una celda con colisión en el mapa

    override method dibujar(position) {
        colisiones.establecerNuevaColision(position)
    }

}

object fr inherits Dibujo { //Representa una celda del freezer en el mapa
    
    override method dibujar(position) {
        freezer.establecerNuevaCeldaDelFreezer(position)
    }
}

object ih inherits Dibujo { //Representa un intermediario en la misma posición del mapa
    
    override method dibujar(position) {
        factoryIntermediarioHere.establecerNuevoIntermediario(position)
    }
}

object iu inherits Dibujo { //Representa un intermediario arriba en el mapa

    override method dibujar(position) {
        factoryIntermediarioUp.establecerNuevoIntermediario(position)
    }
}


object id inherits Dibujo { //Representa un intermediario abajo en el mapa

    override method dibujar(position) {
        factoryIntermediarioDown.establecerNuevoIntermediario(position)
    }
}



object il inherits Dibujo { //Representa un intermediario a la izquierda en el mapa

    override method dibujar(position) {
        factoryIntermediarioLeft.establecerNuevoIntermediario(position)
    }
}

object ir inherits Dibujo { //Representa un intermediario a la derecha en el mapa
    
    override method dibujar(position) {
        factoryIntermediarioRight.establecerNuevoIntermediario(position)
    }
}

//El objeto mapa es el que se encarga de dibujar el mapa del juego, utilizando una matriz de objetos que representan las distintas partes objetos posibles, representados por dos caracteres, recorriendo dicha matriz y llamando al método dibujar de cada objeto en la posición correspondiente.
object mapa {
    const dibujo =[
        [ __, __, __, __, __, cc, cc, cc, cc, cc, __, __, __, __, ir, cc ],
        [ __, __, __, __, __, iu, __, iu, __, iu, __, __, __, __, __, __ ],
        [ __, __, __, __, __, __, __, __, __, __, __, __, __, __, __, __ ],
        [ __, __, __, __, __, cc, __, cc, cc, cc, __, cc, cc, cc, __, cc ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, cc, __, cc ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, iu, __, iu ],
        [ __, __, __, __, __, fr, fr, fr, cc, __, __, __, cc, id, __, id ],
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