import comidas.*
import francella.*
import game.*
import ingredientes.*
import interfazVisual.*


// Electrodomésticos y muebles de cocina-----------------------------------------------

object tachoDeBasura {
  const property position = game.at(9, 7)
  const chef = francella

  method image() {
    return "tachoDeBasura.gif"
  }

  method recibirColocar(item) {
    chef.borrarItemMano()
  }

  method recibirAgarrar() {
    game.say(chef, "No pienso meter la mano ahí")
  }
}

class PiezaDeCocina {
  const property position

  const chef = francella

  method image() 
  //Cada pieza de cocina tiene su imagen

  method recibirColocar(item) {} 
  //Cada pieza de cocina reacciona distinto al recibir el mensaje colocar

  method recibirAgarrar() { 
    //De base todas las piezas de cocina permiten dar lo que tienen, pero el único con este comportamiento base son el horno y las mesadas.
    if (self.puedeAgarrarse()) {
        self.serLevantado()
    }
  }

  method puedeAgarrarse() { 
    //Por defecto todas las piezas de cocina permiten agarrar lo que tengan si francella no tiene nada en mano
    return not chef.tieneItem()
  }

  method serLevantado() {}
    //Su comportamiento depende de cada pieza de cocina

  method serIntercambiado() {
    self.serLevantado()
    chef.dejarItem()
  }

}

class PiezaDeSeccionDeAmasado inherits PiezaDeCocina {

    method factory() { 
      //Dependiendo del caso las piezas de cocina requieren de un factory para crear una instancia del ingrediente que dan. 
    return
  }

  method nuevoIngrediente() {
    //Crea una nueva instancia del ingrediente que da la pieza de la sección de amasado
    return self.factory().instanciaIngrediente(position)
  }

  override method recibirAgarrar() {
    //Cuando francella agarra de una pieza de la sección de amasado, se le agrega el ingrediente correspondiente al inventario si es que puede agarrarse
    if (self.puedeAgarrarse()) {
        chef.agregarAlInventario(self.nuevoIngrediente())
    }
  }
}

object sacoDeHarina inherits PiezaDeSeccionDeAmasado(position = game.at(13, 3)){
  
  override method image() {
    return "sacoDeHarina.png"                   
  }

  override method factory() {
    return factoryHarina
  }
}

object canillaDeAgua inherits PiezaDeSeccionDeAmasado(position = game.at(15, 0)){
  var estaAbierta = false  

  override method image() {
    if (estaAbierta) {
        return "canillaAbierta.gif"                   
    }
    else return "canillaCerrada.gif"                                      
  }

  override method factory() {
    return factoryAgua
  }

  override method recibirAgarrar() {
    //Además de agarrar el ingrediente, la canilla se abre por 1.5 segundos
    self.abrirCanilla()
    game.schedule(1500, {self.cerrarCanilla()})
    super()
  }

  method abrirCanilla() {
    estaAbierta = true
  }

  method cerrarCanilla() {
    estaAbierta = false
  }
}
  

object heladera inherits PiezaDeSeccionDeAmasado(position = game.at(15, 3)){
  
  override method image() {
    return "heladera.png"                   
  }

  override method factory() {
    return factoryLevadura
  }
}



object horno inherits PiezaDeCocina(position = game.at(5, 7)){         
  var estaPrendido = false

  var contenido = vacio
  //Contenido es el item que está dentro del horno

  override method image() {
  //El horno tiene dos estados, de los cuales dará distinta imagen dependiendo de si está prendido o apagado
    if (estaPrendido) {
        return "hornoEncendido.gif"                   
    }
    else return "hornoApagado.png"                    
  }

  override method recibirColocar(item) { 
  //Recibe una pizza, se la saca a francella, se enciende, la cocina y luego se apaga.
    if (chef.tengoUnaPizza()) {
        chef.borrarItemMano()
        contenido = item
        self.prenderHorno()
        game.schedule(5000, {self.cocinarPizza()})
        game.schedule(5000, {self.apagarHorno()})
    }
  }

  override method puedeAgarrarse() { 
  //Se puede agarrar si hay una pizza cocinada dentro del horno
    return self.tieneUnaPizzaCocinada()
  }

  method tieneUnaPizzaCocinada() { 
  //Devuelve true si el contenido del horno es una pizza cocinada
    return contenido.estaCocinada()
  }

  override method serLevantado() { 
  //Le da la pizza cocinada a francella y vacía el horno
    chef.agregarAlInventario(contenido)
    contenido = vacio
  }

  method prenderHorno() {
  //Enciende el horno
    estaPrendido = true
  }

  method apagarHorno() {
  //Apaga el horno
    estaPrendido = false
  }

  method cocinarPizza() {
  //Cocina la pizza que está dentro del horno
    contenido.estaCocinada(true)
  }


}

class Mesada inherits PiezaDeCocina {

  const ingredientesEncima = #{}
  //Ingredientes que están sobre la mesada
  
  method contenido() {
  //Cada mesada tiene un contenido distinto (masa o pizza)
    return 
  }

  method añadirIngrediente(algo) {
  //Agrega un ingrediente a la mesada
    ingredientesEncima.add(algo)
  }

  method limpiarIngredientesEncima() {
  //Limpia los ingredientes que están sobre la mesada
    ingredientesEncima.clear()
  }

  override method recibirColocar(item) {
  //Recibe un ingrediente de francella, se lo saca y lo añade a la mesada
    chef.borrarItemMano()
    self.añadirIngrediente(item)
    ingredientesEnInterfaz.mostrarIngredienteEnInterfaz(item)
  }

  override method serLevantado() {
  //Le da al chef el contenido de la mesada (masa o pizza) con los ingredientes que tiene encima, y limpia los ingredientes encima y en la interfaz
    chef.agregarAlInventario(self.contenido())
    ingredientesEncima.clear()
    ingredientesEnInterfaz.limpiarIngredientesEnInterfaz()
  }
}

object mesadaParaPizza inherits Mesada(position = game.at(7, 7)) {
  
  override method image() {
    return "mesadaPizza.png"
  }

  override method contenido() {
  //El contenido de la mesada para pizza es una pizza con los ingredientes que tiene encima
    return pizza
  }

  override method puedeAgarrarse() {
  //La pizza se puede agarrar si hay al menos un ingrediente encima
    return ingredientesEncima.size() > 0
  }

  override method serLevantado() {
  //Le da al chef una pizza con los ingredientes que tiene encima
    self.contenido().agregarIngredientes(ingredientesEncima)
    super()
  }
}

object mesadaParaMasa inherits Mesada(position = game.at(13,0)) {

  override method image() {
    return "mesadaMasa.png"
  }

  override method contenido() {
  //El contenido de la mesada para masa es una masa
    return masa
  }

  override method puedeAgarrarse() {
  //La masa se puede agarrar si hay los ingredientes necesarios encima
    return self.contenido().hayIngredientesNecesariosEn(ingredientesEncima)
  }
}