import pizzeria.*
import francella.*
import direcciones.*
import interfazVisual.*
import comidas.*
import ingredientes.*

// Objetos de mapa------------------------------------------------------------
//Aca va todo lo relacionado a objetos del mapa en si, como colisiones, freezer e intermediarios de interaccion entre francella y otros objetos.


object colisiones { 
//Objeto encargado de manejar las colisiones en el mapa

    const celdasConColision = #{} 
    //Set de celdas que tienen colision

    method establecerNuevaColision(_position) {
        celdasConColision.add(_position)
    }

    method removerColision(_position) {
        celdasConColision.remove(_position)
    }

    method hayColisionEn(celda) {
        return celdasConColision.contains(celda)
    }
}

class SeccionDelMapa { 
//Clase que representa una sección del mapa, la cual tiene celdas definidas que serán usadas por otros objetos para definir sus áreas de influencia.

    const celdas = #{}

    const victima = francella

    method establecerNuevaCelda(_position) {
        celdas.add(_position)
    }

    method estaVictimaEnCelda(celda) {
    //Chequea si la victima está en la celda dada
        return celda == victima.position()
    }

    method estaVictimaEnLaSeccion() {
    //Chequea si la victima está en alguna de las celdas de la sección
        return celdas.any({celda => self.estaVictimaEnCelda(celda)})
    }

}



object freezer inherits SeccionDelMapa { 
//Establece las celdas a lo referente al freezer, que le quitara vida a francella si está mucho tiempo en ellas.


    method congelarAlVictimaSiEsta() {
    //Cada cierto tiempo chequea si la victima está en el freezer, y si es así le quita vida
        game.onTick(2500, "congelador", {
            if (self.estaVictimaEnLaSeccion()) {
                victima.recibirDanio(1)
            }
        })
    }
}

object almacen inherits SeccionDelMapa {
    //Establece las celdas del almacen, para que la rata persiga a francella solo si esta está dentro de este mismo.

}


// Puertas -------------------------------------------------------------------
object gestorPuertas {
    const puertas = #{puertaDelAlmacen, puertaDelFreezer, puertaDeLaSeccionDeAmasado}

    method iniciarPuertas() {
        puertas.forEach({puerta => puerta.mecanismoCuandoPasaFrancella()})
    }
}
class Puerta {
//Clase que representa una puerta en el mapa, que puede estar abierta o cerrada

    var property position

    var estado = puertaCerrada

    const chef = francella

    method image() {
        return estado.image()
    }

    method abrir() {
        estado = puertaAbierta
    }

    method cerrar() {
        estado = puertaCerrada
    }


    method chefPasaSobreLaPuerta() {
        return chef.position() == position
    }

    method condicionParaAbrir() {
        return true
    }

    method mecanismoCuandoPasaFrancella() {
        game.onTick(100, "puerta", {
            if (self.condicionParaAbrir()) {
                colisiones.removerColision(position)
                self.abrirPuertaTemporalmente()
            }
        })
    }

    method abrirPuertaTemporalmente() {
        if (self.chefPasaSobreLaPuerta()) {
            self.abrir()
            game.schedule(3000, {self.cerrar()})
        }
    }

    method cerrarPuertasQueNoCumplenCondicion() {
        game.onTick(100, "cerrarPuertas", {
            if (not self.condicionParaAbrir()) {
                colisiones.establecerNuevaColision(position)
            }
        })
    }

}

//Puertas disponibles -------------------------------------------------------
object puertaDelAlmacen inherits Puerta (position = game.at(5,3)) {
    override method condicionParaAbrir() {
        return mesadaParaPizza.tieneEncima(masa)
    }
}

object puertaDelFreezer inherits Puerta (position = game.at(15,0)) {
    override method condicionParaAbrir() {
        return  mesadaParaPizza.tieneEncima(salsa) and 
                mesadaParaPizza.tieneEncima(queso)
    }
}

object puertaDeLaSeccionDeAmasado inherits Puerta (position = game.at(15,3)) {
}



//Estados de las puertas -------------------------------------------------------
object puertaAbierta {
    method image() {
        return "puertaAbierta.png"
    }
}

object puertaCerrada {
    method image() {
        return "puertaCerrada.png"
    }
}

// Intermediarios de interaccion -------------------------------------------------------------------
class IntermediarioDeInteraccion { 
//Clase diseñada crear instancias que sirvar para como medio para que francella interaccione con ellos. 

    const property position

    const receptorDeInteraccion

    method image() {
        return "intermediarioPH.gif"
    }

    method recibirColocar(item) {
    //Envía el mensaje recibirColocar al objeto con el que interacciona
        receptorDeInteraccion.recibirColocar(item)
    }

    method recibirAgarrar() {
    //Envía el mensaje recibirAgarrar al objeto con el que interacciona
        receptorDeInteraccion.recibirAgarrar()
    }

}



class FactoryIntermediarioInteraccion { 
//Clase que generaliza el proceso que hace cada factory para crear un intermediario de interacción

    method posicionEstablecida(_position) { 
    //La posición establecida es un método hook que dependerá de cada factory en dónde colocar el intermediario
        return _position
    }

    method objetoEn(_position) { 
    //Establece a qué objeto sirve el intermediador
        return game.getObjectsIn(self.posicionEstablecida(_position)).uniqueElement()
    }

    method establecerNuevoIntermediario(_position) { 
    //Template method que generaliza la creación de intermediarios.
        const nuevoIntermediario = new IntermediarioDeInteraccion (position = _position, receptorDeInteraccion = self.objetoEn(_position))
        game.addVisual(nuevoIntermediario)
    }
}


object factoryIntermediarioHere inherits FactoryIntermediarioInteraccion { 
//Factory de intermediadores que son medio de un objeto en la misma posicion que les fue dada

}

object factoryIntermediarioUp inherits FactoryIntermediarioInteraccion { 
//Factory que crea un intermediador que interacciona con un objeto que se encuentra arriba de la posición dada.

    override method posicionEstablecida(_position) {
        return arriba.siguiente(_position)
    }

}

object factoryIntermediarioDown inherits FactoryIntermediarioInteraccion { 
//Factory que crea un intermediador que interacciona con un objeto que se encuentra abajo de la posición dada.

    override method posicionEstablecida(_position) {
        return abajo.siguiente(_position)
    }

}

object factoryIntermediarioLeft inherits FactoryIntermediarioInteraccion { 
//Factory que crea un intermediador que interacciona con un objeto que se encuentra izquierda de la posición dada.

    override method posicionEstablecida(_position) {
        return izquierda.siguiente(_position)
    }

}



object factoryIntermediarioRight inherits FactoryIntermediarioInteraccion { 
//Factory que crea un intermediador que interacciona con un objeto que se encuentra derecha de la posición dada.

    override method posicionEstablecida(_position) {
        return derecha.siguiente(_position)
    }

}


// Mapa --------------------------------------------------------------------------------------------------------------------------------------------------------

//Cada posible objeto que pueda ser dibujado está representado por dos caracteres, y todos comparten la interfaz dibujon, que tiene el método dibujar(position), que dibuja el objeto en la posición dada.

class Dibujo { 
//Interfaz que comparten todos los objetos dibujables en el mapa

    method dibujar(position) {

    }
}

object __ inherits Dibujo { 
//Representa un espacio vacío en el mapa

}

object cc inherits Dibujo { 
//Representa una celda con colisión en el mapa

    override method dibujar(position) {
        colisiones.establecerNuevaColision(position)
    }

}

object fr inherits Dibujo { 
//Representa una celda del freezer en el mapa
    
    override method dibujar(position) {
        freezer.establecerNuevaCelda(position)
    }
}

object am inherits Dibujo { 
//Representa una celda del almacen en el mapa
    
    override method dibujar(position) {
        almacen.establecerNuevaCelda(position)
    }
}

object ih inherits Dibujo { 
//Representa un intermediario en la misma posición del mapa
    
    override method dibujar(position) {
        factoryIntermediarioHere.establecerNuevoIntermediario(position)
    }
}

object iu inherits Dibujo { 
//Representa un intermediario arriba en el mapa

    override method dibujar(position) {
        factoryIntermediarioUp.establecerNuevoIntermediario(position)
    }
}


object id inherits Dibujo { 
//Representa un intermediario abajo en el mapa

    override method dibujar(position) {
        factoryIntermediarioDown.establecerNuevoIntermediario(position)
    }
}

object il inherits Dibujo { 
//Representa un intermediario a la izquierda en el mapa

    override method dibujar(position) {
        factoryIntermediarioLeft.establecerNuevoIntermediario(position)
    }
}

object ir inherits Dibujo { 
//Representa un intermediario a la derecha en el mapa
    
    override method dibujar(position) {
        factoryIntermediarioRight.establecerNuevoIntermediario(position)
    }
}

object pf inherits Dibujo {
//Representa la puerta del freezer en el mapa
    override method dibujar(position) {
        puertaDelFreezer.position(position)
        colisiones.establecerNuevaColision(position)
        game.addVisual(puertaDelFreezer)
    }
}

object pa inherits Dibujo {
//Representa la puerta del almacen en el mapa
    override method dibujar(position) {
        puertaDelAlmacen.position(position)
        colisiones.establecerNuevaColision(position)
        game.addVisual(puertaDelAlmacen)
    }
}

object pm inherits Dibujo {
//Representa la puerta de la seccion de amasado en el mapa
    override method dibujar(position) {
        puertaDeLaSeccionDeAmasado.position(position)
        colisiones.establecerNuevaColision(position)
        game.addVisual(puertaDeLaSeccionDeAmasado)
    }
}



//El objeto mapa es el que se encarga de dibujar el mapa del juego, utilizando una matriz de objetos que representan las distintas partes objetos posibles, representados por dos caracteres, recorriendo dicha matriz y llamando al método dibujar de cada objeto en la posición correspondiente.
object mapa {
    const dibujo =[
        [ __, __, __, __, __, cc, cc, cc, cc, cc, __, __, __, __, ir, cc ],
        [ __, __, __, __, __, iu, __, iu, __, iu, __, __, __, __, __, __ ],
        [ __, __, __, __, __, __, __, __, __, __, __, __, __, __, __, __ ],
        [ __, __, __, __, __, cc, pf, cc, cc, cc, pa, cc, cc, cc, pm, cc ],
        [ __, __, __, __, __, fr, fr, fr, cc, am, am, am, cc, cc, __, cc ],
        [ __, __, __, __, __, fr, fr, fr, cc, am, am, am, cc, iu, __, iu ],
        [ __, __, __, __, __, fr, fr, fr, cc, am, am, am, cc, id, __, id ],
        [ __, __, __, __, __, fr, fr, fr, cc, am, am, am, cc, cc, cc, cc ]
    ].reverse()

    method dibujarMapa() {
    //Dibuja el mapa en el juego, recorriendo la matriz de dibujo y llamando al método dibujar de cada objeto en la posición correspondiente
        game.height(dibujo.size())
        game.width(dibujo.anyOne().size())
        (0 .. game.width() - 1).forEach({ x => 
            (0 .. game.height() - 1).forEach({y => 
                dibujo.get(y).get(x).dibujar(game.at(x,y))
            })
        })
    }
}