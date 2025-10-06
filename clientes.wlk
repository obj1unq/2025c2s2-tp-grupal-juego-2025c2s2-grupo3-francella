import francella.*
import tiposPizzas.*
import game.*
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
    const property position = game.at(29, 13)

    method tipoDePizzaPedido() {
        return tipoDePizzaPedido
    }
    method image() {
        return "cliente1.png"
    }
    method validarQueEstaCocinada(unaPizza) {
        if (not unaPizza.estaCocinada()) {
            self.error("Esto está crudo papá")
        }
    }
    method validarEsLoQuePedi(unaPizza) {
      if (not self.esLoQuePedi(unaPizza)) {
        game.schedule(3000, {game.say(self, "Flaco esto no es lo que pedí")})
        francella.gameOver()
      }
    }
    method recibirPizza(unaPizza) {
      self.validarQueEstaCocinada(unaPizza)
      self.validarEsLoQuePedi(unaPizza)
      game.say(self, "Gracias mostro")
    }
    method esLoQuePedi(unaPizza) {
        return unaPizza.ingredientes() == tipoDePizzaPedido.ingredientesNecesarios()
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