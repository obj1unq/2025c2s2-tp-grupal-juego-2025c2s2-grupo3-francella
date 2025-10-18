import game.*
import randomizer.*

//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. 
//Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia

// Los tipos de ingredientes son wko en sí mismos.
object salsa {}
object queso {}
object prepizza{}
object tomate{}
object jamon{}
object cebolla{}

class Ingrediente {
    //POSICION ALEATORIA
    const position 
    method position() {
        return position
    }
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
    method tipoIngrediente(){
        return salsa
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
    method tipoIngrediente(){
        return queso
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
    method tipoIngrediente(){
        return prepizza
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
    method tipoIngrediente(){
        return tomate
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
    method tipoIngrediente(){
        return jamon
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
    method tipoIngrediente(){
        return cebolla
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