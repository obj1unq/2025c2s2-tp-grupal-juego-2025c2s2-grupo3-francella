import tiposPizzas.*

class Cliente {
    //POSICION ALEATORIA E IMAGEN
    var property position = game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
    method image()
    //TIPO DE PIZZA DEFINIDO
    const tipoDePizzaPedido = tiposDePizzas.disponibles().anyOne()
    method tipoDePizzaPedido() {
        return tipoDePizzaPedido
    }
}

object cliente1 inherits Cliente {
    //POSICION ALEATORIA
    override method image() {
        return "cliente1.png"
    }
}

object cliente2 inherits Cliente {
    override method image() {
        return ""
    }
}

object cliente3 inherits Cliente {
    override method image() {
        return ""
    }
}