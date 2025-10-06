import francella.*
import game.*

object horno {
  const property position = game.at(10, 14)         
  var estaPrendido = false

  method image() {
    if (estaPrendido) {
        return "hornoEncendido.png"                   
    }
    else return "hornoApagado.png"                    
  }
  method laPizzaSeEstaCocinando(tiempo) {
    game.schedule(tiempo, {estaPrendido = true})
    estaPrendido = false
    game.say(self, "Qué pinta eeh")
  }
  method laPizzaSeCocino() {
    pizza.estaCocinada(true)
  }
}

object mesada {
    const property position = game.at(14, 14)  

    method image() {
        return "mesada.png"                     
    }
    method armarPizza() {
        pizza.ingredientes().add({francella.inventario()})
    }
}

object pizza {
  var property ingredientes = #{}
  var property estaCocinada = false
}
