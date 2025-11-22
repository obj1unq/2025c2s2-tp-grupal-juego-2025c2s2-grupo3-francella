import game.*
import PepesPizzeriaGame.*

//Timer que servirá para mostrar de manera gráfica el tiempo que da el cliente para entregarle una pizza. A fecha de este comentario aún sigue en desarollo.

object timer{

    var tiempoRestante = 0

    method position() = game.at(1,9)

    method start(tiempo){
        self.establecerTiempo(tiempo)
        game.onTick(1000, "timer", {self.correr()})
    }

    method correr(){
        tiempoRestante -= 1
    }

    method establecerTiempo(tiempo){
        tiempoRestante = tiempo
    }

    method text(){
        return tiempoRestante.toString()
    }
}
