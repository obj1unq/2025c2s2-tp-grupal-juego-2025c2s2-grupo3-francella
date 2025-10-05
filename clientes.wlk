import tiposPizzas.*

class Cliente {
    //POSICION ALEATORIA E IMAGEN
    var property position = game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
    method image()
    //TIPO DE PIZZA DEFINIDO
    const tipoDePizzaPedido = tiposDePizzas.disponibles().anyOne()
    method tipoDePizzaPedido() {
        return tipoDePizzaPedido
    }
}

object cliente1 inherits Cliente {
    //POSICION ALEATORIA
    override method image() {
        return "cliente1.png"
    }
    method validarRecibirPizza(unaPizza) {
        if (not unaPizza.estaCocinada()) {
            self.error("Esto está crudo papá")
        }
    }
    method recibirPizza(unaPizza) {
      self.validarRecibirPizza(unaPizza)
      if (self.esLoQuePedi(unaPizza)) {
        game.say(self, "Gracias mostro")
      }
      else {
        game.schedule(5000, {game.say(self, "Flaco esto no es lo que pedí")})
        //texto que diga PERDISTE en el medio de la pantalla???
      }
    }
    method esLoQuePedi(unaPizza) {
        return unaPizza.ingredientes() == tipoDePizzaPedido.ingredientesNecesarios()
    }
}

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