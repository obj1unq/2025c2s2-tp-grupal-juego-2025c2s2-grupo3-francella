import tiposPizzas.*


object cliente1 {
    //POSICION ALEATORIA
 //   var property position = game.at(0.randomUpTo(game.width() - 1),0.randomUpTo(game.height() - 1))
    var property position = game.at(16,9)

    var pizzaDeseada = pizzaMuzzarella

    method image() {
        return "cliente1.png"
    }
}

object cliente2 {
    //POSICION ALEATORIA
    var property position = game.at(0.randomUpTo(game.width() - 1),0.randomUpTo(game.height() - 1))

    var pizzaDeseada = pizzaCebolla

    method image() {
        return ""
    }
}

object cliente3 {
    //POSICION ALEATORIA
    var property position = game.at(0.randomUpTo(game.width() - 1),0.randomUpTo(game.height() - 1))

    var pizzaDeseada = pizzaNapolitana

    method image() {
        return ""
    }
}