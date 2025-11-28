import game.*
import francella.*

class Direccion {

    method nombre()

    method siguiente(position)
}

object izquierda inherits Direccion{

    override method nombre(){
        return "Izquierda"
    }

    override method siguiente(position){
//Direcciones para moverse por el mapa -----------------------

//Es el rango de direcciones por el cual se puede mover francella. Está limitado desde el eje x para que no se sobreponga sobre la parte de la pantalla dedicada a mostrar las mesadas
object izquierda{
    method siguiente(position){
        return game.at(5.max(position.x() - 1), position.y())
    }
}

object derecha inherits Direccion{
    
    override method nombre(){
        return "Derecha"
    }
    
    override method siguiente(position){
        return game.at((game.width() - 1).min(position.x() + 1), position.y())
    }
}

object arriba inherits Direccion{
    
    override method nombre(){
        return "Arriba"
    }
    
    override method siguiente(position){
        return game.at(position.x(), (game.height() - 1).min(position.y() + 1))
    }
}

object abajo inherits Direccion{
    
    override method nombre(){
        return "Abajo"
    }
    
    override method siguiente(position){
        return game.at(position.x(), 0.max(position.y() - 1))
    }
}