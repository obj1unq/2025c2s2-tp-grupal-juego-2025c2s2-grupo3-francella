import interfaz.*
import ingredientes.*
import francella.*
import game.*


object pizza {
  const ingredientes = []
  var property estaCocinada = false

  method ingredientes() {
    return ingredientes
  }

  method agregarIngrediente(unIngrediente) {
    ingredientes.add(unIngrediente)
  }

  method ingredientesUsados() {
    return ingredientes.map({ingrediente => ingrediente.tipoIngrediente()})
  }

  method entregarPizza() {
      ingredientes.clear()
  }
}


// Electrodomésticos y muebles de cocina-----------------------------------------------


object horno {
  const property position = game.at(5, 7)            
  var estaPrendido = false

  method image() {
    if (estaPrendido) {
        return "hornoEncendido.png"                   
    }
    else return "hornoApagado.png"                    
  }

  method atravesable(){
    return false
  }

  method laPizzaSeEstaCocinando(tiempo) {
    estaPrendido = true
    game.schedule(tiempo, {estaPrendido = false; game.say(francella, "Qué pinta eeh")})
  }

  method laPizzaSeCocino() {
    pizza.estaCocinada(true)
  }
}

object mesada {
  const property position = game.at(6, 7)
  var pizzaEnArmado = pizza    

  method image() {
      return "mesada.png"                   
  }

  method atravesable(){
    return false
  }

  method colocarIngredienteEnMesada(ingrediente) {
    pizzaEnArmado.agregarIngrediente(ingrediente)
    ingredientesEnInterfaz.mostrarIngredienteEnInterfaz(ingrediente)
  }

  method sacarPizzaDeMesada() {
    ingredientesEnInterfaz.limpiarIngredientesEnInterfaz()
  }
}