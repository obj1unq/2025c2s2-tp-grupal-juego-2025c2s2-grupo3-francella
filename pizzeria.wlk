import francella.*
import game.*

object horno {
  const property position = game.at(10, 13)             // AGREGAR POSICION
  var estaPrendido = false

  method image() {
    if (estaPrendido) {
        return "hornoEncendido.png"                   // AGREGAR IMAGEN
    }
    else return "hornoApagado.png"                    // AGREGAR IMAGEN
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
    const property position = game.at(14, 13)     // AGREGAR POSICION

    method image() {
        return "mesada.png"                     // AGREGAR IMAGEN
    }
    method armarPizza() {
        pizza.ingredientes().add({francella.inventario()})
    }
}

object pizza {
  var property ingredientes = #{}
  var property estaCocinada = false
}
