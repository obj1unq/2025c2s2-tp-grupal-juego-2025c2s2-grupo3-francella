import game.*
import direcciones.*


object francella{
    var property position   = game.center()
    var property inventario = #{}

    method image(){
        return "pepita.png"
    }

    // MOVIMIENTOS
    method mover(direccion){
        position = direccion.siguiente(self.position())
    }

    //AGARRAR INGREDIENTE
    method validarAgarrarIngrediente() {            // Verifica si hay algun objeto (ingrediente) en la misma posicion de Francella
      if (not self.estoySobreUnIngrediente()) {     // Si no hay ninguno, Francella lo indica en un mensaje.
        self.error("Acá no hay ingredientes")
      }
    }
    method estoySobreUnIngrediente() {
      return game.colliders(self) != []       // Toma la lista de objetos que comparten posicion con "self",
    }                                         // y la compara con la lista vacia, si no son iguales, entonces estoy sobre un ingrediente.
    method agarrarIngrediente() {
      self.validarAgarrarIngrediente()
      inventario.add(#{game.uniqueCollider(self)})  // Agrega al inventario de Francella el objeto (ingrediente) que esta en su misma posicion.
      game.removeVisual(game.uniqueCollider(self))  // Elimino la imagen del objeto que "agarré"
    }

    //COCINAR PIZZA
    method validarCocinarPizza() {
      if (not self.estoyFrenteAlHorno()) {
        self.error("El horno está lejos")
      }
    }
    method estoyFrenteAlHorno() {
      return position == horno.position().down(1)
    }
    method cocinarPizza() {
      game.schedule(5000, {horno.laPizzaSeEstaCocinando()})
      game.say(self, "Qué pinta eeh")
      // falta agregar qué hago con la pizza ya cocinada
      // agregar tambien la mesada para "armarPizza" con los ingredientes que recolecté.
      // posibles objetos: pizza cruda? pizza cocinada?? pensar
    }
}



