import ingredientes.*
import francella.*

object rata{
    var estado = rataEsperando
    var vidas = 3
    const victima = francella

    var property position = estado.position()
    method image() = "ratamalvada.jpg"

    method recibirGolpe(){
        vidas -= 1
    }
    method modoAtaque(){
        estado = rataAtacando
    }
    method inflingirDanio(){
        victima.recibirDanio(4)
    }

}
object rataEsperando{
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