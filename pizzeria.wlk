import francella.*
import game.*

object horno {
  const property position = game.at(10, 13)            
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
}

object mesada {
    const property position = game.at(14, 13)    

    method image() {
        return "mesada.png"                   
    }
}

object pizza {
  var property ingredientes = []
  var property estaCocinada = false

  method agregarIngrediente(unIngrediente) {
    ingredientes.add(unIngrediente)
  }
}
