import comidas.*
import francella.*
import game.*
import interfazVisual.*
import randomizer.*


//Todos los ingredientes pertenecen a una clase a la cual pertenecen dependiendo de que ingrediente sean. 
//Todas las clases heredan de la clase ingrediente la posición aleatoria y el metodo abstracto image el cual cada clase tendrá la suya propia
// Los tipos de ingredientes son wko en sí mismos, y permiten realizar la comparación con el cliente



// Clases de ingredientes -----------------------------------------------------


class Ingrediente {
    // SUPERCLASE ABSTRACTA que sirve para definir los comportamientos de los ingredientes de manera general. Todos reaccionan a los mensajes necesarios para que francella pueda interactuar con ellos.

    var property position
    const chef = francella

    method recibirColocar(item){}

    method recibirAgarrar() { //Los ingredientes al ser agarrados por francella chequean si él tiene un item en mano o no para saber si deben ser levantados o intercambiados
        if (not chef.tieneItem()) {
            self.serLevantado()
        }
        else self.serIntercambiado()
    }
    method serLevantado() { //Si lo levanta, le manda a francella a agregarlo a su inventario, se remueve del mapa y se actualiza la interfaz del inventario
        chef.agregarAlInventario(self)
    }

    method serIntercambiado() {
        self.serLevantado()
        chef.dejarItem()
    }

    method image() //Cada ingrediente tiene su propia imagen

    method visualizacionEnInterfaz() //Cada ingrediente tiene su propia visualización en la interfaz de la mesada

    method tipoIngrediente() //Cada ingrediente tiene su propio tipo para poder ser identificado.
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

class FactoryIngredientes {
    // SUPERCLASE: SE ENCARGA DE LA CREACIÓN DE INSTANCIAS DE LAS CLASES DE CADA INGREDIENTE
    method spawn(_position) { //Cada factory tiene un método spawn que crea una instancia del ingrediente correspondiente en la posición dada
        const nuevoIngrediente = self.instanciaIngrediente(_position)
        game.addVisual(nuevoIngrediente)
    }

    method instanciaIngrediente(_position) //Pero cada factory crea una instancia de una clase distinta.
}

object factorySalsa inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Salsa(position = _position)
    }
}

object factoryQueso inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Queso(position = _position)
    }
}

object factoryTomate inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Tomate(position = _position)
    }
}

object factoryJamon inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Jamon(position = _position)
    }
}

object factoryCebolla inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Cebolla(position = _position)
    }
}

object factoryHarina inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Harina(position = _position)
    }
}

object factoryAgua inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Agua(position = _position)
    }
}

object factoryLevadura inherits FactoryIngredientes {
    override method instanciaIngrediente(_position){
        return new Levadura(position = _position)
    }
}


// WKO que sirven para determinar los tipos de los ingredientes a la hora de las comparaciones:

// object masa{}
object salsa{}
object queso{}
object tomate{}
object cebolla{}
object jamon{}
object levadura{}
object agua{}
object harina{}
