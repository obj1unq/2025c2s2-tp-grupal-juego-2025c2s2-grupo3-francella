import game.*
import direcciones.*
import pizzeria.*
import clientes.*
import interfaz.*

object francella{
    var property position   = game.center()
    var property inventario = []

    method image(){
        return "pepito.png"
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
      return position.x() == mesada.position().x()
          && position.y() == mesada.position().y() - 1
    }
    method armarPizza() {
      self.validarArmarPizza()    // Verifica que estoy frente a la mesada (una celda abajo)
      inventario.forEach({cadaIngrediente => pizza.agregarIngrediente(cadaIngrediente)})   // Arma la pizza en la mesada 
      game.say(self, "*musiquita italiana de fondo*")
      inventario.clear()          // Saca los ingredientes del inventario, ya que la pizza se armó con ellos
      inventario.add(pizza)       // Agrega al inventario la pizza cruda que se armó con los ingredientes recolectados
    }

    //COCINAR PIZZA
    method validarCocinarPizza() {
      if (not self.estoyFrenteAlHorno()) {
        self.error("El horno está lejos")
      }
    }
    method estoyFrenteAlHorno() {
      return position.x() == horno.position().x()
          && position.y() == horno.position().y() - 1
    }
    method cocinarPizza() {
      self.validarCocinarPizza()
      horno.laPizzaSeEstaCocinando(5000)  // Envia el mensaje al horno con el parametro del tiempo en milisegundos
      horno.laPizzaSeCocino()             // La pizza terminó de cocinarse
    }

    //ENTREGAR PIZZA
    method validarEntregarPizza() {
      if (not self.estoyFrenteAlCliente()) {
        self.error("El cliente está lejos")
      }
    }
    method estoyFrenteAlCliente() {
      return position.x() == cliente1.position().x() -1    
          && position.y() == cliente1.position().y()
    }
    method entregarPizza() {
      self.validarEntregarPizza()
      cliente1.recibirPizza(inventario.first())        
      inventario.clear()
    }

    //PERDISTE

    method gameOver() {
      game.addVisual(youDied)
      game.stop()
    }

}



