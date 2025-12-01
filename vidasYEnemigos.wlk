import ingredientes.*
import francella.*
import direcciones.*



//Enemigos del juego -----------------------

//Por el momento (y muy seguramente en la versión final) solo habrá una rata como enemigo en el almacen custiodiando el queso y la salsa. El como persigue a francella y el sistema de vida quedará para más adelante.
object rata{
    var vida              = 3
    const victima         = francella
    var property position = game.at(10,1)

    method image() = "rataMalvada.png"

    method recibirDanio(danio){ 
    //La rata pierde vida de a uno porque es el danio que hace pepe
        vida = 0.max(vida - danio)
        if (vida == 0) {
            factoryQueso.spawn(self.position())
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

    method vida(){
        return vida
    }


    // PERSECUSION -----------------------------------------------------------------------------------


    method iniciarPersecusion(){ 
    //Prepara a la rata para atacar a francella
        game.onTick(2000, "Persecusión de la rata", {self.moverseHaciaVictima() self.inflingirDanio()})
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



