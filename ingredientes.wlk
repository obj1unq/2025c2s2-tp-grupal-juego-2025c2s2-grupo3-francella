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
        return " "
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
        return " "
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
        return " "
    }
}

