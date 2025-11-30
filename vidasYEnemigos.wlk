import ingredientes.*
import francella.*
import direcciones.*
import mapa.*

//Sistema de vidas-----------------------------------------------------------

//Sistema de vidas rudimentario que está desacoplado de francella. En futuras versiones puede ser modelado para que interactue con francella u otros cambios.

object sistemaVidas {
    var vidas = self.vidasMaximas()
    //Francella empieza con la cantidad máxima de vidas

    method position() {
        return game.at(10,7)
    }

    method image() {
        return "corazones" + vidas.toString() + ".png"
    }

    method vidas() {
        return vidas
    }

    method restarVidas(cantidad) {
    //Resta vidas hasta llegar a 0
        vidas -= self.vidasMaximas().min(cantidad)
    }

    method restaurarVidas(cantidad) {
    //Restaura vidas hasta el máximo permitido
        vidas = (vidas + cantidad).min(self.vidasMaximas())
    }

    method vidasMaximas() {
    //El sistema de vidas tiene 3 vidas máximas
        return 3
    }
}

//Enemigos del juego -----------------------

//Por el momento (y muy seguramente en la versión final) solo habrá una rata como enemigo en el almacen custiodiando el queso y la salsa. El como persigue a francella y el sistema de vidas quedará para más adelante.
object rata{
    var vidas             = 3
    const victima         = francella
    var property position = game.at(9,3)

    method image() = "ratamalvada.jpg"

    method recibirDanio(puntosDeVida){ 
    //La rata pierde vidas de a uno
        vidas -= puntosDeVida
        if (vidas <= 0) {
            game.removeVisual(self) 
            game.removeTickEvent("Persecusión de la rata")
        }
    }
    
    method inflingirDanio(){ 
    //La rata infligue 2 de daño
        if (game.onSameCell(francella.position(), self.position())) {
            victima.recibirDanio(2)
        }
    }

    method vidas(){
        return vidas
    }


    // PERSECUSION -----------------------------------------------------------------------------------


    method iniciarPersecusion(){ 
    //Prepara a la rata para atacar a francella
        game.onTick(3000, "Persecusión de la rata", {self.perseguirAVictima() self.inflingirDanio()})
    }

    method perseguirAVictima() {
        if (self.laVictimaEntroAlAlmacen()) {
            self.moverseHaciaVictima()
        }
    }

    method moverseHaciaVictima() {
        // Compara la posición de francella con la propia para poder dirigirse hacia él.
        if (self.laVictimaEstaHaciaArribaOHaciaAbajo()) {
            self.elegirArribaOAbajo()
        }
        else self.elegirIzquierdaODerecha()
    }

    method elegirArribaOAbajo() {
        if (self.laVictimaEstaAbajo()) {
            position = abajoPersecusion.movimientoSiguiente(self.position(), victima.position())
        }
        else position = arribaPersecusion.movimientoSiguiente(self.position(), victima.position())
    }

    method elegirIzquierdaODerecha() {
        if (self.laVictimaEstaALaDerecha()) {
            position = derechaPersecusion.movimientoSiguiente(self.position(), victima.position())
        }
        else position = izquierdaPersecusion.movimientoSiguiente(self.position(), victima.position())
    }


    // BOOLEANOS --------------------------------------------------------------------------------------------------------

    method laVictimaEntroAlAlmacen() {
        return almacen.estaVictimaEnLaSeccion()
    }

    method laVictimaEstaALaDerecha() {
        return self.position().x() - victima.position().x() > victima.position().x() - self.position().x()
    }

    method laVictimaEstaAbajo() {
        return self.position().y() - victima.position().y() > victima.position().y() - self.position().y()
    }

    method laVictimaEstaHaciaArribaOHaciaAbajo() {
        // esto capaz se puede simplificar eliminando el abs y usando una logica similar a la de los otros dos booleanos?
        return self.abs(self.position().x() - victima.position().x()) < self.abs(self.position().y() - victima.position().y())
    }

    // esto tiene que ir en otro lado aunque tampoco se si es necesario pero quedo
    method abs(numero) {
        return numero.max(numero * -1)
    }
}



