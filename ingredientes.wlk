import comidas.*
import francella.*
import game.*
import interfazVisual.*
import randomizer.*


//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. 
//Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia
// Los tipos de ingredientes son wko en sí mismos.



// Clases de ingredientes -----------------------------------------------------


class Ingrediente {
    // SUPERCLASE ABSTRACTA que sirve para definir los comportamientos de los ingredientes

    var property position
    const chef = francella

    method recibirColocar(item){}

    method recibirAgarrar() {
        if (not chef.tieneItem()) {
            self.serLevantado()
        }
        else self.serIntercambiado()
    }
    method serLevantado() {
        chef.agregarAlInventario(self)
        game.removeVisual(self)
        interfazInventario.cambiarContenidoMostrado(self)
        gestorIngredientes.eliminarDeCocina(self)
    }
    method serIntercambiado() {
        self.serLevantado()
        chef.dejarItem()
    }

    method image()

    method visualizacionEnInterfaz()

    method tipoIngrediente()
}


// class IngredienteParaPizza inherits Ingrediente{
// Todos los ingredientes deberían ser de la misma clase, sin importar si se usan para la masa o para la pizza
// }


class Salsa inherits Ingrediente{

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


class Queso inherits Ingrediente{

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

// QUÉ PASA CON ESTA CLASE? ES UN INGREDIENTE O ES UNA COMIDA???
 /* class Masa inherits Ingrediente{

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
*/


class Tomate inherits Ingrediente{

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


class Jamon inherits Ingrediente{

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


class Cebolla inherits Ingrediente{

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

class Harina inherits Ingrediente{
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

class Agua inherits Ingrediente{
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

class Levadura inherits Ingrediente{
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

// Factories para la creación de instancias de ingredientes -------------------------------------------------

class Factory{
    // SUPERCLASE: SE ENCARGA DE LA CREACIÓN DE INSTANCIAS DE LAS CLASES DE CADA INGREDIENTE
    method spawn(_position) {
        const nuevoIngrediente = self.instanciaIngrediente(_position)
        game.addVisual(nuevoIngrediente)
    }
    method instanciaIngrediente(_position)
}
object factorySalsa inherits Factory {
    override method instanciaIngrediente(_position){
        return new Salsa(position = _position)
    }
}

object factoryQueso inherits Factory {
    override method instanciaIngrediente(_position){
        return new Queso(position = _position)
    }
}

object factoryTomate inherits Factory{
    override method instanciaIngrediente(_position){
        return new Tomate(position = _position)
    }
}

object factoryJamon inherits Factory{
    override method instanciaIngrediente(_position){
        return new Jamon(position = _position)
    }
}

object factoryCebolla inherits Factory{
    override method instanciaIngrediente(_position){
        return new Cebolla(position = _position)
    }
}

object factoryHarina inherits Factory{
    override method instanciaIngrediente(_position){
        return new Harina(position = _position)
    }
}

object factoryAgua inherits Factory{
    override method instanciaIngrediente(_position){
        return new Agua(position = _position)
    }
}

object factoryLevadura inherits Factory{
    override method instanciaIngrediente(_position){
        return new Levadura(position = _position)
    }
}


// WKO que sirven para determinar los tipos de los ingredientes:

// object masa{}
object salsa{}
object queso{}
object tomate{}
object cebolla{}
object jamon{}
object levadura{}
object agua{}
object harina{}
