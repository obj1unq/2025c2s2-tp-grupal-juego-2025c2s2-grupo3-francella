import comidas.*
import francella.*
import game.*
import interfazVisual.*
import randomizer.*


//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. 
//Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia
// Los tipos de ingredientes son wko en sí mismos.


object ingredientes {
    const ingredientesEnCocina = #{}

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

    method image()

    method visualizacionEnInterfaz()

    method tipoIngrediente()
}


class IngredienteParaPizza inherits Ingrediente{
    var property position
    const chef = francella

    method recibirAgarrar() {
        if (not chef.tieneItem()) {
            self.serLevantado()
        }
        else {
            self.serIntercambiado()
        }
    }

    method serLevantado() {
        chef.itemEnMano().add(self)
        game.removeVisual(self)
        ingredientes.eliminarDeCocina(self)
        interfazInventario.cambiarContenidoMostrado(self)
    }

    method serIntercambiado() {
        self.serLevantado()
        ingredientes.agregarACocina(chef.itemEnMano().first())
        chef.dejarItem()
    }

    method recibirColocar(item) {}
}


class Salsa inherits IngredienteParaPizza{

    override method image() {
        return "salsa.png"
    }

     override method tipoIngrediente(){
        return salsa
    }
    
    override method visualizacionEnInterfaz() {
        return salsaInterfaz
    }
}


class Queso inherits IngredienteParaPizza{

    override method image() {
        return "queso.jpeg"
    }

    override method tipoIngrediente(){
        return queso
    }

    override method visualizacionEnInterfaz() {
        return quesoInterfaz
    }
}


class Masa inherits IngredienteParaPizza{

    override method image() {
        return "masa.jpg"
    }

    override method tipoIngrediente(){
        return masa
    }

    override method visualizacionEnInterfaz() {
        return masaInterfaz
    }
}


class Tomate inherits IngredienteParaPizza{

    override method image() {
        return "tomate.jpeg"
    }

     override method tipoIngrediente(){
        return tomate
    }

    override method visualizacionEnInterfaz() {
        return tomateInterfaz
    }
}


class Jamon inherits IngredienteParaPizza{

    override method image() {
        return "jamon.jpg"
    }

    override method tipoIngrediente(){
        return jamon
    }

    override method visualizacionEnInterfaz() {
        return jamonInterfaz
    }
}


class Cebolla inherits IngredienteParaPizza{

    override method image() {
        return "cebolla.jpg"
    }

    override method tipoIngrediente(){
        return cebolla
    }

    override method visualizacionEnInterfaz() {
        return cebollaInterfaz
    }
}


// Instancias de ingredientes -------------------------------------------------


object salsa {

    method spawn(_position) {
        const nuevaSalsa = new Salsa(position = _position)
        game.addVisual(nuevaSalsa)
        ingredientes.agregarACocina(nuevaSalsa)
    }
}

object queso {

    method spawn(_position) {
        const nuevoQueso = new Queso(position = _position)
        game.addVisual(nuevoQueso)
        ingredientes.agregarACocina(nuevoQueso)
    }
}

object tomate{
    
    method spawn(_position) {
        const nuevoTomate = new Tomate(position = _position)
        game.addVisual(nuevoTomate)
        ingredientes.agregarACocina(nuevoTomate)
    }
}

object jamon{
    
    method spawn(_position) {
        const nuevoJamon = new Jamon(position = _position)
        game.addVisual(nuevoJamon)
        ingredientes.agregarACocina(nuevoJamon)
    }
}

object cebolla{
    
    method spawn(_position) {
        const nuevaCebolla = new Cebolla(position = _position)
        game.addVisual(nuevaCebolla)
        ingredientes.agregarACocina(nuevaCebolla)
    }
}


// Ingredientes para masa -------------------------------------------------


object harina inherits Ingrediente{

    override method image() {
        return "harina.png"
    }

    override method tipoIngrediente(){
        return harina
    }

    override method visualizacionEnInterfaz() {
        return harinaInterfaz
    }
}

object agua inherits Ingrediente{

    override method image() {
        return "agua.png"
    }

    override method tipoIngrediente(){
        return agua
    }

    override method visualizacionEnInterfaz() {
        return aguaInterfaz
    }
}

object levadura inherits Ingrediente{

    override method image() {
        return "levadura.png"
    }

    override method tipoIngrediente(){
        return levadura
    }

    override method visualizacionEnInterfaz() {
        return levaduraInterfaz
    }
}