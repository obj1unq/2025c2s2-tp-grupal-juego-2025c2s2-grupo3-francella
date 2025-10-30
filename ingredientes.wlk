import game.*
import randomizer.*


//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. 
//Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia
// Los tipos de ingredientes son wko en sí mismos.


object ingredientes {
    var ingredientesEnCocina = #{}

    method agregarACocina(ingrediente) {
        ingredientesEnCocina.add(ingrediente)
    }

    method eliminarDeCocina(ingrediente) {
        ingredientesEnCocina.remove(ingrediente)
    }

    method esUnIngrediente(ingrediente) {
        return ingredientesEnCocina.contains(ingrediente)
    }
}


object salsa {
    method tipoIngrediente() {
        return self
    }

    method spawn() {
        const nuevaSalsa = new Salsa(position = randomizer.emptyPosition())
        game.addVisual(nuevaSalsa)
        ingredientes.agregarACocina(nuevaSalsa)
    }
}

object queso {
    method tipoIngrediente() {
        return self
    }

    method spawn() {
        const nuevoQueso = new Queso(position = randomizer.emptyPosition())
        game.addVisual(nuevoQueso)
        ingredientes.agregarACocina(nuevoQueso)
    }
}
object prepizza{
    method tipoIngrediente() {
        return self
    }
    
    method spawn() {
        const nuevaPrepizza = new Prepizza(position = randomizer.emptyPosition())
        game.addVisual(nuevaPrepizza)
        ingredientes.agregarACocina(nuevaPrepizza)
    }
}
object tomate{
    method tipoIngrediente() {
        return self
    }
    
    method spawn() {
        const nuevoTomate = new Tomate(position = randomizer.emptyPosition())
        game.addVisual(nuevoTomate)
        ingredientes.agregarACocina(nuevoTomate)
    }
}
object jamon{
    method tipoIngrediente() {
        return self
    }
    
    method spawn() {
        const nuevoJamon = new Jamon(position = randomizer.emptyPosition())
        game.addVisual(nuevoJamon)
        ingredientes.agregarACocina(nuevoJamon)
    }
}
object cebolla{
    method tipoIngrediente() {
        return self
    }
    
    method spawn() {
        const nuevaCebolla = new Cebolla(position = randomizer.emptyPosition())
        game.addVisual(nuevaCebolla)
        ingredientes.agregarACocina(nuevaCebolla)
    }
}


class Ingrediente {
    //POSICION ALEATORIA
    var property position

    method image()

    method atravesable(){
        return true
    }
}


class Salsa inherits Ingrediente{

    override method image() {
        return "salsa.png"
    }

    method tipoIngrediente(){
        return salsa
    }
}


class Queso inherits Ingrediente{

    override method image() {
        return "queso.jpeg"
    }

    method tipoIngrediente(){
        return queso
    }
}


class Prepizza inherits Ingrediente{

    override method image() {
        return "prepizza.jpg"
    }

    method tipoIngrediente(){
        return prepizza
    }
}


class Tomate inherits Ingrediente{

    override method image() {
        return "tomate.jpeg"
    }

    method tipoIngrediente(){
        return tomate
    }
}


class Jamon inherits Ingrediente{

    override method image() {
        return "jamon.jpg"
    }

    method tipoIngrediente(){
        return jamon
    }
}


class Cebolla inherits Ingrediente{

    override method image() {
        return "cebolla.jpg"
    }

    method tipoIngrediente(){
        return cebolla
    }
}


// dante: yo borraria esto de los wko pq no creo q lo usemos
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