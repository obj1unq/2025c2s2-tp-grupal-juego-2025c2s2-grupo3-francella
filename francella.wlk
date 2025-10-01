import game.*
import direcciones.*

object francella{
    var property position = game.center()
    method image(){
        return "pepita.png"
    }

// MOVIMIENTOS
    method mover(direccion){
        position = direccion.siguiente(self.position())
    }
}

