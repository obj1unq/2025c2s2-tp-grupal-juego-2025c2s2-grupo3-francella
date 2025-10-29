import game.*
import randomizer.*

//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. 
//Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia

// Los tipos de ingredientes son wko en sí mismos.
object salsa {
    method tipoIngrediente() {
        return self
    }
}
object queso {
    method tipoIngrediente() {
        return self
    }
}
object prepizza{
    method tipoIngrediente() {
        return self
    }
}
object tomate{
    method tipoIngrediente() {
        return self
    }
}
object jamon{
    method tipoIngrediente() {
        return self
    }
}
object cebolla{
    method tipoIngrediente() {
        return self
    }
}

class Ingrediente {
    //POSICION ALEATORIA
    const position
    const nombre
    method position() {
        return position
    }
    method image()
    method nombre() {
        return nombre
    }
}

class Salsa inherits Ingrediente(nombre = "salsa") {
    override method image() {
        return "salsa.png"
    }
    method tipoIngrediente(){
        return salsa
    }
}

class Queso inherits Ingrediente(nombre = "queso") {
    override method image() {
        return "queso.jpeg"
    }
    method tipoIngrediente(){
        return queso
    }
}

class Prepizza inherits Ingrediente(nombre = "prepizza") {
    override method image() {
        return "prepizza.jpg"
    }
    method tipoIngrediente(){
        return prepizza
    }
}

class Tomate inherits Ingrediente(nombre = "tomate"){
    override method image() {
        return "tomate.jpeg"
    }
    method tipoIngrediente(){
        return tomate
    }
}

class Jamon inherits Ingrediente(nombre = "jamon"){
    override method image() {
        return "jamon.jpg"
    }
    method tipoIngrediente(){
        return jamon
    }
}


class Cebolla inherits Ingrediente(nombre = "cebolla"){
    override method image() {
        return "cebolla.jpg"
    }
    method tipoIngrediente(){
        return cebolla
    }
}

// Esto quedó de cuando los ingredientes eran WKO
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