import ingredientes.*
import francella.*

//Sistema de vidas-----------------------------------------------------------

//Sistema de vidas rudimentario que está desacoplado de francella. En futuras versiones puede ser modelado para que interactue con francella u otros cambios.

object sistemaVidas {
    var vidasLlenas = self.vidasMaximas()
    //Francella empieza con la cantidad máxima de vidas

    method position() {
        return game.at(10,7)
    }

    method image() {
        return "corazones" + vidasLlenas.toString() + ".png"
    }

    method vidasLlenas() {
        return vidasLlenas
    }

    method restarVidas(cantidad) {
    //Resta vidas hasta llegar a 0
        vidasLlenas -= self.vidasMaximas().min(cantidad)
    }

    method restaurarVidas(cantidad) {
    //Restaura vidas hasta el máximo permitido
        vidasLlenas = (vidasLlenas + cantidad).min(self.vidasMaximas())
    }

    method vidasMaximas() {
    //El sistema de vidas tiene 3 vidas máximas
        return 3
    }
}

//Enemigos del juego -----------------------

//Por el momento (y muy seguramente en la versión final) solo habrá una rata como enemigo en el almacen custiodiando el queso y la salsa. El como persigue a francella y el sistema de vidas quedará para más adelante.
object rata{
    var estado = rataEsperando
    var vidas = 3
    const victima = francella

    var property position = estado.position()
    method image() = "ratamalvada.jpg"

    method recibirGolpe(){ 
    //La rata pierde vidas de a uno
        vidas -= 1
    }

    method modoAtaque(){ 
    //Prepara a la rata para atacar a francella
        estado = rataAtacando
    }

    method inflingirDanio(){ 
    //La rata infligue 4 de daño
        victima.recibirDanio(4)
    }

}
object rataEsperando{ 
//El estado inicial de la rata, antes de empezar a perseguir a francella
    method position() = game.at(9,3)
}

object rataAtacando{
    method position(){
        // lo tiene que comparar con algo, pero sería position?
        //if ()
    }
    // cómo modelamos la persecusión?!?!?!
    // la idea sería ir comparando self.position.x() con la de francella para poder ir moviéndose en esa dirección
    // method position() tiene que ser persiguiendo a francella de alguna manera
}