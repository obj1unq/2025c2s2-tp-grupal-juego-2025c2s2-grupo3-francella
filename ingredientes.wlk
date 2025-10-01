import game.*

object salsa{
    // POSICIÓN ALEATORIA
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    method position(){
        return game.at(x, y)
    }
    method image(){
        return "salsa.png"
    }
}

object queso{
    // POSICIÓN ALEATORIA
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    method position(){
        return game.at(x, y)
    }
    method image(){
        return "queso.jpeg"
    }
}

object prepizza{
    // POSICIÓN ALEATORIA
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    method position(){
        return game.at(x, y)
    }
    method image(){
        return "prepizza.jpg"
    }
}

object tomate{
    // POSICIÓN ALEATORIA
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    method position(){
        return game.at(x, y)
    }
    method image(){
        return "tomate.jpeg"
    }
}

object jamon{
    // POSICIÓN ALEATORIA
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    method position(){
        return game.at(x, y)
    }
    method image(){
        return "jamon.jpg"
    }
}

object cebolla{
    // POSICIÓN ALEATORIA
    const x = 0.randomUpTo(game.width()).truncate(0)
    const y = 0.randomUpTo(game.height()).truncate(0)

    method position(){
        return game.at(x, y)
    }
    method image(){
        return "cebolla.jpg"
    }
}