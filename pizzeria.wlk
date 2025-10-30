import francella.*
import game.*

object horno {
  const property position = game.at(5, 7)            
  var estaPrendido = false

  method image() {
    if (estaPrendido) {
        return "hornoEncendido.png"                   
    }
    else return "hornoApagado.png"                    
  }
  method laPizzaSeEstaCocinando(tiempo) {
    estaPrendido = true
    game.schedule(tiempo, {estaPrendido = false; game.say(francella, "Qué pinta eeh")})
  }
  method laPizzaSeCocino() {
    pizza.estaCocinada(true)
  }
  method atravesable(){
    return false
  }
}

object mesada {
  const property position = game.at(6, 7)    

  method image() {
      return "mesada.png"                   
  }

  method atravesable(){
    return false
  }
}

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
}
