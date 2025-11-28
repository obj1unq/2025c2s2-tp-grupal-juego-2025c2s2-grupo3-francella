import ingredientes.*
import francella.*

//Sistema de vidas-----------------------------------------------------------

//Sistema de vidas rudimentario que está desacoplado de francella. En futuras versiones puede ser modelado para que interactue con francella u otros cambios.

object sistemaVidas {
    var vidasLlenas = self.vidasMaximas()
    //Francella empieza con la cantidad máxima de vidas

    method position() {
        return game.at(10,7)
    }

    method image() {
        return "corazones" + vidasLlenas.toString() + ".png"
    }

    method vidasLlenas() {
        return vidasLlenas
    }

    method restarVidas(cantidad) {
    //Resta vidas hasta llegar a 0
        vidasLlenas -= self.vidasMaximas().min(cantidad)
    }

    method restaurarVidas(cantidad) {
    //Restaura vidas hasta el máximo permitido
        vidasLlenas = (vidasLlenas + cantidad).min(self.vidasMaximas())
    }

    method vidasMaximas() {
    //El sistema de vidas tiene 3 vidas máximas
        return 3
    }
}

//Enemigos del juego -----------------------

//Por el momento (y muy seguramente en la versión final) solo habrá una rata como enemigo en el almacen custiodiando el queso y la salsa. El como persigue a francella y el sistema de vidas quedará para más adelante.
object rata{
    var estado = rataAtacando
    var vidas = 3
    const victima = francella

    var property position = estado.position()
    method image() = "ratamalvada.jpg"

    method recibirGolpe(){ 
    //La rata pierde vidas de a uno
        vidas -= 1
    }

    method modoAtaque(){ 
    //Prepara a la rata para atacar a francella
        estado = rataAtacando
        estado.iniciarMovimiento()
    }

    method inflingirDanio(){ 
    //La rata infligue 4 de daño
        victima.recibirDanio(4)
    }

}
object rataEsperando{ 
    //El estado inicial de la rata, antes de empezar a perseguir a francella
    method position() = game.at(9,3)
}

object rataAtacando{
    const victima = francella

    var property position = game.at(9, 1)

    // Métodos para poder obtener los valores de x e y en cada momento
    method x() = self.position().x()
    method y() = self.position().y()

    // Máximo de x
    method maxX() = 11

    method movimiento(){
        game.onTick(500, "Rata en movimiento", {self.trasladarse()})
    }

    method trasladarse(){
        if (self.x() < self.maxX()){
            self.position().right(1)
        }
        else if (self.x() == self.maxX()){
            self.position().left(2)
        }
    }

        
    // method iniciarMovimiento(){ // NO FUNCIONA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //     // Comienza un onTick para mover a la rata hacia francella cada cierto tiempo
    //     game.onTick(500, "Persecusión de la rata", {self.moverseHaciaVictima()})
    // }

    // method moverseHaciaVictima(){ // NO FUNCIONA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //     // Compara la posición de francella con la propia para poder dirigirse hacia él.
    //     if(victima.x() > self.x()) {self.position().right(1)}
    //     if(victima.x() < self.x()) {self.position().left(1)}
    //     if(victima.y() > self.y()) {self.position().up(1)}
    //     if(victima.y() < self.y()) {self.position().down(1)}
    // }

}




