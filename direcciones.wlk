import game.*
import francella.*
import mapa.*

//Direcciones para moverse por el mapa:
//Son las direcciones hacia las cuales se puede mover el jugador. Están limitadas desde el eje x para no moverse sobre la seccion de la pantalla dedicada a mostrar las mesadas


class DireccionJugador {

    method nombre()

    method siguiente(position)
}


object izquierda inherits DireccionJugador{

    override method nombre(){
        return "Izquierda"
    }

    override method siguiente(position){
        return game.at(5.max(position.x() - 1), position.y())
    }
}

object derecha inherits DireccionJugador{
    
    override method nombre(){
        return "Derecha"
    }
    
    override method siguiente(position){
        return game.at((game.width() - 1).min(position.x() + 1), position.y())
    }
}

object arriba inherits DireccionJugador{
    
    override method nombre(){
        return "Arriba"
    }
    
    override method siguiente(position){
        return game.at(position.x(), (game.height() - 1).min(position.y() + 1))
    }
}

object abajo inherits DireccionJugador{
    
    override method nombre(){
        return "Abajo"
    }
    
    override method siguiente(position){
        return game.at(position.x(), 0.max(position.y() - 1))
    }
}


// Direcciones de persecusión:
// Son las direcciones que usan los enemigos para perseguir al jugador y asegurarse de no seguir de largo una vez que se encuentren sobre el mismo.


class DireccionPersecusion{
    
    method direccionSiguiente(enemigoPosition, victimaPosition)

    method movimientoSiguiente(enemigoPosition, victimaPosition) {
        if (self.noHayColisionables(enemigoPosition, victimaPosition)) {
            return self.direccionSiguiente(enemigoPosition, victimaPosition)
        }
        else {
            return enemigoPosition
        }
    }

    method noHayColisionables(enemigoPosition, victimaPosition){
        return not colisiones.hayColisionEn(self.direccionSiguiente(enemigoPosition, victimaPosition))
    }
}


object izquierdaPersecusion inherits DireccionPersecusion{

    override method direccionSiguiente(enemigoPosition, victimaPosition){
        return game.at(victimaPosition.x().max(enemigoPosition.x() - 1), enemigoPosition.y())
    }
}

object derechaPersecusion inherits DireccionPersecusion{
    
    override method direccionSiguiente(enemigoPosition, victimaPosition){
        return game.at(victimaPosition.x().min(enemigoPosition.x() + 1), enemigoPosition.y())
    }
}

object arribaPersecusion inherits DireccionPersecusion{
    
    override method direccionSiguiente(enemigoPosition, victimaPosition){
        return game.at(enemigoPosition.x(), victimaPosition.y().min(enemigoPosition.y() + 1))
    }
}

object abajoPersecusion inherits DireccionPersecusion{
    
    override method direccionSiguiente(enemigoPosition, victimaPosition){
        return game.at(enemigoPosition.x(), victimaPosition.y().max(enemigoPosition.y() - 1))
    }
}