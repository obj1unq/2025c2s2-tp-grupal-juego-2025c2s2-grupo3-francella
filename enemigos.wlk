import ingredientes.*
import francella.*

object rata{
    var estado = rataEsperando
    var vidas = 3

    var property position = estado.position()
    method image() = cebolla

    method recibirGolpe(){
        vidas -= 1
    }
}

object freezer{
    // Al ingresar al freezer, constantemente se tendría que enviar el mensaje inflingirDaño con algún
    // onTick para ir disminuyendo las vidas de francella
    const victima = francella
    method inflingirDaño(){
        victima.recibirGolpe()
    }
}

object rataEsperando{
    method position() = game.at(5,7)
}

object rataAtacando{
    // cómo modelamos la persecusión?!?!?!
    // method position() tiene que ser persiguiendo a francella de alguna manera
}