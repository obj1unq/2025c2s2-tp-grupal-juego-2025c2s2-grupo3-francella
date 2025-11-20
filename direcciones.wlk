import game.*
import francella.*

//Direcciones para moverse por el mapa -----------------------

//Es el rango de direcciones por el cual se puede mover francella. Está limitado desde el eje x para que no se sobreponga sobre la parte de la pantalla dedicada a mostrar las mesadas
object izquierda{
    method siguiente(position){
        return game.at(5.max(position.x() - 1), position.y())
    }
}

object derecha{
    method siguiente(position){
        return game.at((game.width() - 1).min(position.x() + 1), position.y())
    }
}

object arriba{
    method siguiente(position){
        return game.at(position.x(), (game.height() - 1).min(position.y() + 1))
    }
}

object abajo{
    method siguiente(position){
        return game.at(position.x(), 0.max(position.y() - 1))
    }
}