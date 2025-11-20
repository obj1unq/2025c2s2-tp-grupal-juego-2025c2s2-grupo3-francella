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
    const clienteActual     = cliente1
    var vidas               = 10
    var ultimaDireccion     = abajo

    method image(){
        return "pepito" + ultimaDireccion.nombre() + ".png"
    }

    method image(newImage) {
        return newImage
    }

    method recibirDanio(cantidadDeDanio) {
        vidas -= cantidadDeDanio
    }

    // BOOLEANOS -------------------------------------------------------------------------------


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

    method hayEnemigoAdelante() {
        return not game.getObjectsIn(ultimaDireccion).isEmpty() // and como carajo saco un booleano lindo de esto
    }
    

    // MOVIMIENTOS -----------------------------------------------------------------------------


    method mover(direccion) {
        ultimaDireccion = direccion
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

    method agregarAlInventario(algo) {
      // Lo necesita la clase IngredienteParaPizza en 'ingredientes'
      itemEnMano.add(algo)
    }
  

    //ATACAR ------------------------------------------------------------------------------------


    method atacar() {
      self.image("pepitoAtacando" + ultimaDireccion.nombre() + ".png")
      game.schedule(100, self.image("pepito" + ultimaDireccion.nombre() + ".png"))
      if (self.hayEnemigoAdelante()) {
        game.getObjectsIn(ultimaDireccion).uniqueElement().recibirDanio(1)
      }
    }


    //GAMESTATES --------------------------------------------------------------------------------


    method gameState(visual) {
      game.stop()
      game.addVisual(visual)
    }

    method gameOver() {
      game.schedule(3000, {self.gameState(gameOver)})
    }

    method gameWin() {
      game.schedule(3000, {self.gameState(gameWin)})
    }


    // VALIDADORES --------------------------------------------------------------------------------


    method validarSiTengoPizzaEnMano() {
      if (self.tengoUnaPizza()) {
        self.error("No puedo dejar esta pizza acá")
      }
    }
}



