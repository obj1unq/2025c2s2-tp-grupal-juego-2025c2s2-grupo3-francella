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

  const chef = francella

  method image()

  method factory() {
    return
  }

  method recibirColocar(item) {}

  method recibirAgarrar() {
    if (self.puedeAgarrarse()) {
        self.serLevantado()
    }
    else {
        self.serIntercambiado()
    }
  }

  method puedeAgarrarse() {
    return not chef.tieneItem()
  }

  method serLevantado() {
    chef.itemEnMano().add(self.nuevoIngrediente())
  }

  method nuevoIngrediente() {
    return self.factory().instanciaIngrediente(position)
  }

  method serIntercambiado() {
    self.serLevantado()
    chef.dejarItem()
  }

}

class PiezaDeSeccionDeAmasado inherits PiezaDeCocina {
  override method recibirAgarrar() {
    if (self.puedeAgarrarse()) {
        const nuevoIngrediente = self.nuevoIngrediente()
        chef.itemEnMano().add(nuevoIngrediente)
        interfazInventario.cambiarContenidoMostrado(nuevoIngrediente)
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

  override method image() {
    if (estaPrendido) {
        return "hornoEncendido.gif"                   
    }
    else return "hornoApagado.png"                    
  }

  override method recibirColocar(item) {
    if (chef.tengoUnaPizza()) {
        interfazInventario.borrarContenidoMostrado()
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
    chef.itemEnMano().add(contenido)
    interfazInventario.cambiarContenidoMostrado(contenido)
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

  const ingredientesEncima = #{}
  
  override method recibirColocar(item) {
    chef.itemEnMano().clear()
    ingredientesEncima.add(item)
    interfazInventario.borrarContenidoMostrado()
    ingredientesEnInterfaz.mostrarIngredienteEnInterfaz(item)
  }

  override method serLevantado() {
    chef.itemEnMano().add(self.contenido())
    ingredientesEncima.clear()
    interfazInventario.cambiarContenidoMostrado(self.contenido())
    ingredientesEnInterfaz.limpiarIngredientesEnInterfaz()
  }

  override method recibirAgarrar() {
    if (self.puedeAgarrarse()) {
      super()
    }
  }

  method contenido() {
    return 
  }
}

object mesadaParaPizza inherits Mesada(position = game.at(7, 7)) {
  
  override method image() {
    return "mesadaPizzaTest.png"
  }

  override method contenido() {
    return pizza
  }

  override method puedeAgarrarse() {
    return ingredientesEncima.size() > 0
  }

  override method serLevantado() {
    self.contenido().agregarIngredientes(ingredientesEncima)
    super()
  }
}

object mesadaParaMasa inherits Mesada(position = game.at(13,0)) {

  override method image() {
    return "mesadaMasa.png"
  }

  override method contenido() {
    return masa
  }

  override method puedeAgarrarse() {
    return self.contenido().hayIngredientesNecesariosEn(ingredientesEncima)
  }
}