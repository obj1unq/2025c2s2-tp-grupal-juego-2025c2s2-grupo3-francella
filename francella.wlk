import game.*
import direcciones.*
import pizzeria.*
import clientes.*


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

    //ARMAR PIZZA
    method validarArmarPizza() {
      if (not self.estoyFrenteALaMesada()) {
        self.error("La mesada esta lejos")
      }
    }
    method estoyFrenteALaMesada() {
      return position == mesada.position().down(1)
    }
    method armarPizza() {
      self.validarArmarPizza()    // Verifica que estoy frente a la mesada (una celda abajo)
      mesada.armarPizza()         // Arma la pizza en la mesada (envia el mensaje a mesada)
      inventario.clear()          // Saca los ingredientes del inventario, ya que la pizza se armó con ellos
      inventario.add({pizza})     // Agrega al inventario la pizza cruda que se armó con los ingredientes recolectados
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
      horno.laPizzaSeEstaCocinando(5000)  // Envia el mensaje al horno con el parametro del tiempo en milisegundos
      horno.laPizzaSeCocino()             // La pizza terminó de cocinarse
      game.say(self, "Qué pinta eeh")     // Pepe contempla la pizza sacada del horno.
    }

    //ENTREGAR PIZZA
    method validarEntregarPizza() {
      if (not self.estoyFrenteAlCliente()) {
        self.error("El cliente está lejos")
      }
    }
    method estoyFrenteAlCliente() {
      return position == cliente1.position().left(1)    // REVISAR CLIENTE
    }
    method entregarPizza() {
      cliente1.recibirPizza(inventario.first())         // REVISAR CLIENTE
      inventario.clear()
    }

}



