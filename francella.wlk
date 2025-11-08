import audio.*
import clientes.*
import comidas.*
import direcciones.*
import game.*
import ingredientes.*
import interfazVisual.*
import mapa.*
import pizzeria.*


object francella{
    var property position   = game.at(15,6)
    var property itemEnMano = []
    const clienteActual       = cliente1

    method image(){
        return "pepitoHD.png"
    }


    // BOOLEANOS -------------------------------------------------------------------------------


    method estoySobreUnIngrediente() {                                  // Estoy sobre un ingrediente si y solo si:
      return !self.esCeldaVacia()                                       //La celda actual no está vacía
          && ingredientes.esUnIngrediente(game.uniqueCollider(self))    //El objeto con el que colisiono es un ingrediente
    } 

    method tengoUnaPizza() {
      return itemEnMano.contains(pizza)
    }

    method esCeldaVacia() {
      return game.colliders(self).isEmpty()
    }

    method tieneItem() {
      return !itemEnMano.isEmpty()
    }

    method hayMasDeUnItemEnLaCelda() {
        return game.colliders(self).size() > 1
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


    method agarrar() {
      //Proposito: envía el mensaje agarrar al interactuador de objetos agarrables (pizza en armado o cocción, masa en armado e ingredientes)
      self.validarSiTengoPizzaEnMano()
      if (not self.esCeldaVacia()) {
          self.agarrarSiHayVariosItem()
      }
    }

    method agarrarSiHayVariosItem() {
      if (self.hayMasDeUnItemEnLaCelda()) {
          game.colliders(self).get(1).recibirAgarrar()
      }
      else game.uniqueCollider(self).recibirAgarrar()
    }

    method dejarItem() {
      itemEnMano.first().position(position)
      game.addVisual(itemEnMano.first())
      itemEnMano.remove(itemEnMano.first())
    }

    method colocar() {
      //Proposito: envpia el mensaje colocar al interactuador de objetos colocables (mesada para pizza, mesada para masa, horno y cliente)
      if (not self.esCeldaVacia() and self.tieneItem()) {
          game.uniqueCollider(self).recibirColocar(itemEnMano.uniqueElement())
      }
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


    // VALIDADORES --------------------------------------------------------------------------------


    method validarSiTengoPizzaEnMano() {
      if (self.tengoUnaPizza()) {
        self.error("No puedo dejar esta pizza acá")
      }
    }

    method validarTengoUnaPizza() {
      if (!self.tengoUnaPizza()) {
        self.error("No tengo una pizza")
      }
    }
}



