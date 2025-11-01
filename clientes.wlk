import francella.*
import tiposPizzas.*
import game.*
import interfaz.*
import pizzeria.*


/*
class Cliente {
    //POSICION ALEATORIA E IMAGEN
    var property position = game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
    method image()
    //TIPO DE PIZZA DEFINIDO
}
*/


object cliente1  {
    const tipoDePizzaPedido = tiposDePizzas.disponibles().anyOne()
    const property position = game.at(15, 7)

    method image() {
        return "cliente1.png"
    }

    method atravesable(){ // capaz nos maten por esto
        return false
    }

    // Recibimiento de pizza

    method validarQueEstaCocinada(unaPizza) {
        if (not unaPizza.estaCocinada()) {
            self.error("Esto está crudo papá")
        }
    }

    method recibirPizza(unaPizza) {
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
        game.addVisual(gameWin) // esto es para debuggear
    }

    method recibirPizzaIncorrecta() {
        game.say(self, "Flaco, esto no es lo que pedí")
        game.schedule(1500, {francella.gameOver()})
    }

    method esLoQuePedi(unaPizza) {
        return unaPizza.ingredientesUsados() == tipoDePizzaPedido.ingredientesNecesarios()
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

    method tipoDePizzaPedido() {
        return tipoDePizzaPedido
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