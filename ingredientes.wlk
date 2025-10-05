import game.*

//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia
class Ingrediente {
    //POSICION ALEATORIA
    var property position = game.at( 
					(10.. game.width() - 1).anyOne(),
					(0..  game.height() - 1).anyOne()
		)
    method image()


}

class Salsa inherits Ingrediente {
    const nombre = "salsa"
    override method image() {
        return "salsa.png"
    }
    method nombre() {
        return nombre
    }
}

class Queso inherits Ingrediente {
    const nombre = "queso"
    override method image() {
        return "queso.jpeg"
    }
    method nombre() {
        return nombre
    }
}

class Prepizza inherits Ingrediente {
    const nombre = "prepizza"
    override method image() {
        return "prepizza.jpg"
    }
    method nombre() {
        return nombre
    }
}

class Tomate inherits Ingrediente {
    const nombre = "tomate"
    override method image() {
        return "tomate.jpeg"
    }
    method nombre() {
        return nombre
    }
}

class Jamon inherits Ingrediente {
    const nombre = "jamon"
    override method image() {
        return "jamon.jpg"
    }
    method nombre() {
        return nombre
    }
}


class Cebolla inherits Ingrediente {
    const nombre = "cebolla"
    override method image() {
        return "cebolla.jpg"
    }
    method nombre() {
        return nombre
    }
}


/*object salsa{
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
}*/