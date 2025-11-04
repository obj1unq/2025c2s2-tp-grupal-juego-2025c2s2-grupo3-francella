import interfaz.*
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


// Clases de ingredientes -----------------------------------------------------


class Ingrediente {
    var property position

    method image()

    method visualizacionEnInterfaz()
}


class Salsa inherits Ingrediente{

    override method image() {
        return "salsa.png"
    }

    method tipoIngrediente(){
        return salsa
    }
    
    override method visualizacionEnInterfaz() {
        return salsaInterfaz
    }
}


class Queso inherits Ingrediente{

    override method image() {
        return "queso.jpeg"
    }

    method tipoIngrediente(){
        return queso
    }

    override method visualizacionEnInterfaz() {
        return quesoInterfaz
    }
}


class Masa inherits Ingrediente{

    override method image() {
        return "masa.jpg"
    }

    method tipoIngrediente(){
        return masa
    }

    override method visualizacionEnInterfaz() {
        return masaInterfaz
    }
}


class Tomate inherits Ingrediente{

    override method image() {
        return "tomate.jpeg"
    }

    method tipoIngrediente(){
        return tomate
    }

    override method visualizacionEnInterfaz() {
        return tomateInterfaz
    }
}


class Jamon inherits Ingrediente{

    override method image() {
        return "jamon.jpg"
    }

    method tipoIngrediente(){
        return jamon
    }

    override method visualizacionEnInterfaz() {
        return jamonInterfaz
    }
}


class Cebolla inherits Ingrediente{

    override method image() {
        return "cebolla.jpg"
    }

    method tipoIngrediente(){
        return cebolla
    }

    override method visualizacionEnInterfaz() {
        return cebollaInterfaz
    }
}


// Instancias de ingredientes -------------------------------------------------


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
object masa{
    method tipoIngrediente() {
        return self
    }
    
    method spawn() {
        const nuevaMasa = new Masa(position = randomizer.emptyPosition())
        game.addVisual(nuevaMasa)
        ingredientes.agregarACocina(nuevaMasa)
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