import audio.*
import ingredientes.*
import game.*
import direcciones.*
import pizzeria.*
import clientes.*
import interfaz.*
import colisiones.*


object francella{
    var property position   = game.at(15,6)
    var property itemEnMano = []
    const clienteActual       = cliente1

    method image(){
        return "pepitoHD.png"
    }


    // MOVIMIENTOS -----------------------------------------------------------------------------

    method mover(direccion) {
        if (self.puedeMover(direccion)) {
            position = direccion.siguiente(self.position())
        }
    }

    method puedeMover(direccion) {
		  return not colisiones.hayColisionEn(direccion.siguiente(self.position()))
	  }

    //INTERACTUAR ---------------------------------------------------------------------------------
    // Con esto así creo que deberia borrar muchas validaciones sobre la posicion del personaje con respecto
    // de la de los objetos con los que interactuamos, ya que solo enviará los mensajes si se encuentra frente a esos objetos.

    method interactuar() {
      if (self.estoySobreUnIngrediente()) {
        self.agarrarIngrediente()
      }
      if (self.estoyFrenteALaMesada()) {
        self.colocarIngredienteEnMesada()
      }
      if (self.estoyFrenteAlHorno()) {
        self.cocinarPizza()
      }
      if (self.estoyFrenteAlCliente()) {
        self.entregarPizza()
      }
    }

    method confirmar() {
      self.armarPizza()
    }
    method denegar() {
      game.say(self, "Necesito más ingredientes")
    }

    //AGARRAR INGREDIENTE----------------------------------------------------------------------------------------
    //Francella solo puede agarrar una cosa a la vez
    //Si tiene una pizza en la mano, no puede agarrar ingredientes
    //Si tiene un ingrediente en la mano, puede intercambiarlo por otro

    method validarSiEstoySobreUnIngrediente() {     // Verifica si hay algun objeto (ingrediente) en la misma posicion de Francella
      if (not self.estoySobreUnIngrediente()) {     // Si no hay ninguno, Francella lo indica en un mensaje.
        self.error("Acá no hay ingredientes")
      }
    }

    method estoySobreUnIngrediente() {                                  // Estoy sobre un ingrediente si y solo si:
      return !self.esCeldaVacia()                                       //La celda actual no está vacía
          && ingredientes.esUnIngrediente(game.uniqueCollider(self))    //El objeto con el que colisiono es un ingrediente
    } 

    method esCeldaVacia() {
      return game.colliders(self).isEmpty()
    }

    method agarrarIngrediente() {                           //Para agarrar un ingrediente:
      self.validarSiEstoySobreUnIngrediente()               //Tengo que estar sobre un ingrediente
      self.validarNoTengoPizzaEnMano()                      //No tengo que tener una pizza en la mano
          
      if (!self.tieneItem()) {                              //Si no tengo ningun item
        self.levantarItem()                                 //Agarro el ingrediente
      }
      else self.intercambiarItem()                          //Si tengo un item, los intercambio
    }

    method validarNoTengoPizzaEnMano() {
      if (self.tienePizzaEnMano()) {
        self.error("No puedo dejar esta pizza acá")
      }
    }
    method tienePizzaEnMano() {
      return itemEnMano.contains(pizza)
    }
    
    method intercambiarItem() {
      self.levantarItem()
      self.dejarItem()
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
    method tieneItem() {
      return !itemEnMano.isEmpty()
    }


    //ARMAR PIZZA ---------------------------------------------------------------------------------------------
    method validarEstoyFrenteALaMesada() {
      if (!self.estoyFrenteALaMesada()) {
        self.error("La mesada esta lejos")
      }
    }
    method estoyFrenteALaMesada() {
      return position == game.at(mesada.position().x(), mesada.position().y() - 1)
    }
    method validarColocarItem() {
      if (!self.tieneItem()) {
        self.error("No tengo nada para colocar en la mesada")
      }
    }

    method colocarIngredienteEnMesada() {                             // Si estoy frente a la mesada y tengo algun item, puedo colocar el item
      self.validarEstoyFrenteALaMesada()
      self.validarColocarItem()

      mesada.colocarIngredienteEnMesada(itemEnMano.uniqueElement())   // Esta funcion tambien testea cada vez que coloco un item, si el conjunto de
      itemEnMano.clear()                                              // items en la mesada corresponden con alguna pizza, y pregunta si queres armar
    }                                                                 // dicha pizza

    method armarPizza() {
      self.validarEstoyFrenteALaMesada()

      if (!self.tieneItem()) {
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


    //COCINAR PIZZA ----------------------------------------------------------------------------------------------------
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


    //ENTREGAR PIZZA -----------------------------------------------------------------------------------------------
    method validarEntregarItem() {
      if (!self.tieneItem()) {
        self.error("No tengo nada para darle al cliente")
      }
    }
    method validarEstoyFrenteAlCliente() {
      if (not self.estoyFrenteAlCliente()) {
        self.error("El cliente está lejos")
      }
    }

    method estoyFrenteAlCliente() {
      return position == game.at(clienteActual.position().x(), clienteActual.position().y() - 1)
    }
    method entregarPizza() {
      self.validarEstoyFrenteAlCliente()
      self.validarEntregarItem()

      clienteActual.recibirPizza(itemEnMano.first())
      itemEnMano.clear()
    }


    //PERDER --------------------------------------------------------------------------------

    method gameOver() {
      game.stop()
      game.addVisual(gameOver)
    }

    method gameWin() {
      game.stop()
      game.addVisual(gameWin)
    }
}



