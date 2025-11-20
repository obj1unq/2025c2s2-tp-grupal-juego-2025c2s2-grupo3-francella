import francella.*
import comidas.*
import game.*
import interfazVisual.*
import pizzeria.*


object cliente1  {

    const tipoDePizzaPedido = tiposDePizzas.disponibles().anyOne()
    //El tipo de pizza que el cliente va a pedir de los disponibles

    const property position = game.at(15, 7)

    const chef = francella

    method image() {
        return "cliente1.png"
    }

    // Recibimiento de pizza

    method validarQueEstaCocinada(unaPizza) {
    //Valida que la pizza esté cocinada, sino lanza una excepción
        if (not unaPizza.estaCocinada()) {
            self.error("Esto está crudo papá")
        }
    }

    method recibirColocar(unaPizza) {
    //Recibe la pizza que francella le da y valida primero que esté cocinada y luego si es lo que pidió, haciendo las acciones correspondientes
        self.validarQueEstaCocinada(unaPizza)
        if (not self.esLoQuePedi(unaPizza)) {
            self.recibirPizzaIncorrecta()
        }
        else self.recibirPizzaCorrecta()
    }

    method recibirPizzaCorrecta() {
    //Si la pizza es correcta, agradece y se gana el juego
        game.say(self, "Gracias mostro")
        pizza.entregarPizza()
        game.removeVisual(pedido)
        chef.borrarItemMano()
        chef.gameWin()
    }

    method recibirPizzaIncorrecta() {
    //Si la pizza es incorrecta, se enoja y el juego termina
        game.say(self, "Flaco, esto no es lo que pedí")
        game.schedule(1500, {chef.gameOver()})
    }

    method esLoQuePedi(unaPizza) {
    //Devuelve true si la pizza que le dieron coincide con la que pidió
        return unaPizza.coincideCon(tipoDePizzaPedido)
    }

    method recibirAgarrar() {
    //Accion por defecto para recordarle a francella lo que él pidió
        game.say(self, "Flaco te dije que quería una " + tipoDePizzaPedido.nombreDeLaPizza() + ", metele")
    }

    // Pedido

    method hacerPedido() {
    //El cliente hace su pedido al iniciar el juego
        game.say(self, "Quiero ordenar una " + tipoDePizzaPedido.nombreDeLaPizza())
        self.anotarPedido()
    }

    method anotarPedido() {
    //Agrega el pedido a la interfaz visual de pedidos
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