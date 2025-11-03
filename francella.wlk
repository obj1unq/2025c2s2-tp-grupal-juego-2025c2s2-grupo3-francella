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
        return "pepitoHD.png"
    }

    method atravesable(){
      return true
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

    method validarPizzaEnMano() {
      if (self.tienePizzaEnMano()) {
        self.error("No puedo dejar esta pizza acá")
      }
    }

    method tienePizzaEnMano() {
      return self.tieneItem() and itemEnMano.uniqueElement() == pizza
    }

    method tieneItem() {
      return not self.noTieneItem()
    }
    
    method agarrarIngrediente() {
      self.validarAgarrarIngrediente()
      self.validarPizzaEnMano()
      
      if (self.noTieneItem()) {
        self.levantarItem()
      }
      else self.intercambiarItem()
    }

    method levantarItem() {
      itemEnMano.add(game.uniqueCollider(self))
        game.removeVisual(game.uniqueCollider(self))
    }

    method dejarItem() {
      itemEnMano.first().position(position)
      game.addVisual(itemEnMano.first())
      itemEnMano.remove(itemEnMano.first())
    }

    method intercambiarItem() {
      self.levantarItem()
      self.dejarItem()
    }

    method noTieneItem() {
      return itemEnMano.isEmpty()
    }


    //ARMAR PIZZA


    method validarDistanciaAMesada() {
      if (not self.estoyFrenteALaMesada()) {
        self.error("La mesada esta lejos")
      }
    }

    method validarColocarItem() {
      if (self.noTieneItem()) {
        self.error("No tengo nada para colocar en la mesada")
      }
    }

    method estoyFrenteALaMesada() {
      return position == game.at(mesada.position().x(), mesada.position().y() - 1)
    }

    method colocarIngredienteEnMesada() {
      self.validarDistanciaAMesada()
      self.validarColocarItem()

      mesada.colocarIngredienteEnMesada(itemEnMano.uniqueElement())
      itemEnMano.clear()
    }

    method armarPizza() {
      self.validarDistanciaAMesada()

      if (self.noTieneItem()) {
        self.levantarPizza()
      }
      else self.intercambiarItemPorPizza()
    }

    method levantarPizza() {
      itemEnMano.add(pizza)
      mesada.sacarPizzaDeMesada()
      game.say(self, "*musiquita italiana de fondo*") 
    }

    method intercambiarItemPorPizza() {
      self.levantarPizza()
      self.dejarItem()
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
      if (self.noTieneItem()) {
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



