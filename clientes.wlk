import francella.*
import comidas.*
import game.*
import interfazVisual.*
import pizzeria.*


object cliente1  {
    const tipoDePizzaPedido = tiposDePizzas.disponibles().anyOne()
    const property position = game.at(15, 7)
    const chef = francella

    method image() {
        return "cliente1.png"
    }

    // Recibimiento de pizza

    method validarQueEstaCocinada(unaPizza) {
        if (not unaPizza.estaCocinada()) {
            self.error("Esto está crudo papá")
        }
    }

    method recibirColocar(unaPizza) {
        self.validarQueEstaCocinada(unaPizza)
        if (not self.esLoQuePedi(unaPizza)) {
            self.recibirPizzaIncorrecta()
        }
        else self.recibirPizzaCorrecta()
    }

    method recibirPizzaCorrecta() {
        game.say(self, "Gracias mostro")
        pizza.entregarPizza()
        game.removeVisual(pedido)
        chef.itemEnMano().clear()
        chef.gameWin()
    }

    method recibirPizzaIncorrecta() {
        game.say(self, "Flaco, esto no es lo que pedí")
        game.schedule(1500, {chef.gameOver()})
    }

    method esLoQuePedi(unaPizza) {
        return unaPizza.coincideCon(tipoDePizzaPedido)
    }

    method recibirAgarrar() {
        game.say(self, "Flaco te dije que quería una " + tipoDePizzaPedido.nombreDeLaPizza() + ", metele")
    }

    // Pedido

    method hacerPedido() {
        game.say(self, "Quiero ordenar una " + tipoDePizzaPedido.nombreDeLaPizza())
        self.anotarPedido()
    }

    method anotarPedido() {
        pedido.ultimaPizzaPedida(tipoDePizzaPedido.nombreDeLaPizza())
        game.addVisual(pedido)
    }
}

/*
object cliente2 inherits Cliente {
    override method image() {
        return ""
    }
}

object cliente3 inherits Cliente {
    override method image() {
        return ""
    }
}
*/