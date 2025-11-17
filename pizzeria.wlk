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
    chef.itemEnMano().clear()
    interfazInventario.borrarContenidoMostrado()
  }

  method recibirAgarrar() {
    game.say(chef, "No pienso meter la mano ahí")
  }
}

class PiezaDeCocina {
  const property position
  var contenido
  const chef = francella

  method image()

  method recibirColocar(item) {}

  method recibirAgarrar() {
    if (not chef.tieneItem()) {
        self.serLevantado()
    }
    else {
        self.serIntercambiado()
    }
  }

  method serLevantado() {
    chef.itemEnMano().add(contenido)
  }

  method serIntercambiado() {
    self.serLevantado()
    chef.dejarItem()
  }

}

class PiezaDeSeccionDeAmasado inherits PiezaDeCocina {
  override method recibirAgarrar() {
    if (not chef.tieneItem()) {
        chef.itemEnMano().add(contenido)
        interfazInventario.cambiarContenidoMostrado(contenido)
    }
  }
}

object sacoDeHarina inherits PiezaDeSeccionDeAmasado(position = game.at(13, 3), contenido = harina){
  
  override method image() {
    return "sacoDeHarina.png"                   
  }
}

object canillaDeAgua inherits PiezaDeSeccionDeAmasado(position = game.at(15, 0), contenido = agua){
  var estaAbierta = false  

  override method image() {
    if (estaAbierta) {
        return "canillaAbierta.gif"                   
    }
    else return "canillaCerrada.gif"                                      
  }

  override method recibirAgarrar() {
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
  

object heladera inherits PiezaDeSeccionDeAmasado(position = game.at(15, 3), contenido = levadura){
  
  override method image() {
    return "heladera.png"                   
  }
}

object forro {} // quiero poner null y no me dejaaaaaaaaaaaa dios necesito terminar ya

object horno inherits PiezaDeCocina(position = game.at(5, 7), contenido = forro){         
  var estaPrendido = false

  override method image() {
    if (estaPrendido) {
        return "hornoEncendido.png"                   
    }
    else return "hornoApagado.png"                    
  }

  override method recibirColocar(item) {
    if (chef.tengoUnaPizza()) {
        contenido = item
        chef.itemEnMano().clear()
        self.prenderHorno()
        game.schedule(5000, {self.cocinarPizza()})
        game.schedule(5000, {self.apagarHorno()})
    }
  }

  override method recibirAgarrar() {
    if (self.tieneUnaPizzaCocinada()) {
      super()
    }
  }

  override method serLevantado() {
    super()
    contenido = null
  }

  method prenderHorno() {
    estaPrendido = true
  }

  method apagarHorno() {
    estaPrendido = false
  }

  method cocinarPizza() {
    contenido.estaCocinada(true)
  }

  method tieneUnaPizzaCocinada() {
    return contenido != null and contenido.estaCocinada()
  }
}

class Mesada inherits PiezaDeCocina {

  override method recibirColocar(item) {
    contenido.agregarIngrediente(item)
    chef.itemEnMano().clear()
    interfazInventario.borrarContenidoMostrado()
    ingredientesEnInterfaz.mostrarIngredienteEnInterfaz(item)
  }

  override method serLevantado() {
    super()
    ingredientesEnInterfaz.limpiarIngredientesEnInterfaz()
  }

  override method recibirAgarrar() {
    if (contenido.puedeAgarrarse()) {
      super()
    }
  }
}

object mesadaParaPizza inherits Mesada(position = game.at(7, 7), contenido = pizza) {
  
  override method image() {
    return "mesadaPizzaTest.png"
  }
}

object mesadaParaMasa inherits Mesada(position = game.at(13,0), contenido = masa) {

  override method image() {
    return "mesadaMasa.png"
  }
}