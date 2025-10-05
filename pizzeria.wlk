import francella.*
import game.*

object horno {
  const property position = game.at(x, y)
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
  }
  method laPizzaSeCocino() {
    pizza.estaCocinada(true)
  }
}

object mesada {
    const property position = game.at(x, y)

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
