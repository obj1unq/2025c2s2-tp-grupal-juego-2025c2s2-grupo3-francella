import audio.*
import clientes.*
import comidas.*
import direcciones.*
import game.*
import ingredientes.*
import interfazVisual.*
import mapa.*
import pizzeria.*
import vidasYEnemigos.*


object francella{
    var property position   = game.at(15,6)
    var property itemEnMano = []
    var ultimaDireccion     = abajo
    var estadoActual        = relajado

    method image(){
        return "pepito" + estadoActual.nombre() + ultimaDireccion.nombre() + ".gif"
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

    method hayAlgoAdelante() {
      return not ((game.getObjectsIn(ultimaDireccion.siguiente(self.position()))).isEmpty())
    }
    
    method estoyFueraDePeligro() {
      return not freezer.estaVictimaEnElFreezer()
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
      // Proposito: Agrega el item dado al inventario de francella. Además actualiza la interfaz de inventario.
      itemEnMano.add(algo)
      interfazInventario.cambiarContenidoMostrado(algo)
      
    }
    method agregarAlInventarioDelPiso(algo) {
      // Necesaria para agregar ingredientes del suelo, removiendolos visualmente.
      self.agregarAlInventario(algo)
      game.removeVisual(algo)
    }

    method borrarItemMano() { 
      //Borra lo que tiene francella en mano.
      itemEnMano.clear()
      interfazInventario.borrarContenidoMostrado()
    }

  
    //SISTEMA DE VIDAS -----------------------------------------------------------------------


    method recibirDanio(cantidad) {
      sistemaVidas.restarVidas(cantidad)
      self.perderSiNoTieneVidas()
    }

    method perderSiNoTieneVidas() {
      if (sistemaVidas.vidas() == 0) {
        self.gameOver()
      }
    }

    method restaurarVidasReposo() {
      game.onTick(5000, "restaurarVidas", {
        if (self.estoyFueraDePeligro()) {
          sistemaVidas.restaurarVidas(1)
        }
      })
    }


    //ATACAR ------------------------------------------------------------------------------------


    method atacar() {
      estadoActual = atacando
      game.schedule(250, {estadoActual = relajado})
      if (self.hayAlgoAdelante()) {
        game.getObjectsIn(ultimaDireccion.siguiente(self.position())).uniqueElement().recibirDanio(1)
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


// ESTADOS DE PEPE --------------------------------------------------------------------------------


class Estado {

    method nombre()
}

object relajado inherits Estado {

    override method nombre() {
        return "Relajado"
    }
}

object atacando inherits Estado {

    override method nombre() {
        return "Atacando"
    }
}


