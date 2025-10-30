import ingredientes.*
import game.*
import direcciones.*
import pizzeria.*
import clientes.*
import interfaz.*


object francella{
    var property position   = game.center()
    var property itemEnMano = []
    var clienteActual       = cliente1

    method image(){
        return "pepito.png"
    }


    // MOVIMIENTOS


    method mover(direccion){
        self.validarMovimiento(direccion.siguiente(self.position()))
        self.puedeMover(direccion.siguiente(self.position()))
        position = direccion.siguiente(self.position())
    }

    method validarMovimiento(direccion){
      if (not self.puedeMover(direccion)){
        self.error("No puedo ir ahí")
      }
    }

    method puedeMover(siguientePosicion) {
		  return game.getObjectsIn(siguientePosicion).all({visual => visual.atravesable()})
	  }

    method atravesable(){
      return true
    }


    //AGARRAR INGREDIENTE


    method validarAgarrarIngrediente() {            // Verifica si hay algun objeto (ingrediente) en la misma posicion de Francella
      if (not self.estoySobreUnIngrediente()) {     // Si no hay ninguno, Francella lo indica en un mensaje.
        self.error("Acá no hay ingredientes")
      }
    }

    method estoySobreUnIngrediente() {
      return (not self.esCeldaVacia()) and ingredientes.esUnIngrediente(game.uniqueCollider(self))   
    } 
    method esCeldaVacia() {
      return game.colliders(self).isEmpty()
    }       
    
    method agarrarIngrediente() {
      self.validarAgarrarIngrediente()
      if ((itemEnMano).isEmpty()) {
        itemEnMano.add(game.uniqueCollider(self))  // Agrega al itemEnMano de Francella el objeto (ingrediente) que esta en su misma posicion.
        game.removeVisual(game.uniqueCollider(self))
      }
      else itemEnMano.add(game.uniqueCollider(self))
           game.removeVisual(game.uniqueCollider(self)) // ya se que da error, ok?
           itemEnMano.first().position(position)
           game.addVisual(itemEnMano.first())
           itemEnMano.remove(itemEnMano.first())
    }


    //ARMAR PIZZA


    method validarDistanciaAMesada() {
      if (not self.estoyFrenteALaMesada()) {
        self.error("La mesada esta lejos")
      }
    }

    method validarColocarItem() {
      if (itemEnMano.isEmpty()) {
        self.error("No tengo nada para colocar en la mesada")
      }
    }

    method estoyFrenteALaMesada() {
      return position == game.at(mesada.position().x(), mesada.position().y() - 1)
    }

    method colocarIngredienteEnMesada() {
      self.validarDistanciaAMesada()
      self.validarColocarItem()
      mesada.colocarIngredienteEnMesada(itemEnMano.first())
      itemEnMano.clear()
    }

    method armarPizza() {
      self.validarDistanciaAMesada()
      itemEnMano.clear()
      itemEnMano.add(pizza)
      game.say(self, "*musiquita italiana de fondo*")
    }


    //COCINAR PIZZA


    method validarCocinarPizza() {
      if (not self.estoyFrenteAlHorno()) {
        self.error("El horno está lejos")
      }
    }

    method estoyFrenteAlHorno() {
      return position == game.at(horno.position().x(), horno.position().y() - 1)
    }

    method cocinarPizza() {
      self.validarCocinarPizza()
      horno.laPizzaSeEstaCocinando(5000)  // Envia el mensaje al horno con el parametro del tiempo en milisegundos
      horno.laPizzaSeCocino()             // La pizza terminó de cocinarse
    }


    //ENTREGAR PIZZA


    method validarEntregarItem() {
      if (itemEnMano.isEmpty()) {
        self.error("No tengo nada para darle al cliente")
      }
    }

    method validarDistanciaAlCliente() {
      if (not self.estoyFrenteAlCliente()) {
        self.error("El cliente está lejos")
      }
    }

    method estoyFrenteAlCliente() {
      return position == game.at(clienteActual.position().x(), clienteActual.position().y() - 1)
    }

    method entregarPizza() {
      self.validarDistanciaAlCliente()
      self.validarEntregarItem()
      clienteActual.recibirPizza(itemEnMano.first())        
      itemEnMano.clear()
    }


    //PERDER


    method gameOver() {
      game.stop()
      game.addVisual(gameOver)
    }

}



