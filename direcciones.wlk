import game.*
import francella.*

object izquierda{
    method siguiente(position){
        return game.at(10.max(position.x() - 1), position.y())
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