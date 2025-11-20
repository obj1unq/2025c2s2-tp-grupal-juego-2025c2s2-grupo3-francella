import francella.*
import comidas.*
import game.*
import interfazVisual.*
import pizzeria.*

class Cliente {
    const tipoDePizzaPedido = tiposDePizzas.disponibles().anyOne()
    const property position = game.at(15, 7)
    const chef = francella

    method image() {
        return "cliente.png"
    }

    // HACER PEDIDO ---------------------------------------------------------------------------------------------
    method hacerPedido() {
        game.say(self, "Quiero ordenar una " + tipoDePizzaPedido.nombreDeLaPizza())
        self.anotarPedido()
    }
    method anotarPedido() {
        pedido.ultimaPizzaPedida(tipoDePizzaPedido.nombreDeLaPizza())
        game.addVisual(pedido)
    }
    method tipoDePizzaPedido() {
        return tipoDePizzaPedido
    }

    // RECIBIR PIZZA ---------------------------------------------------------------------------------------------
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
}
