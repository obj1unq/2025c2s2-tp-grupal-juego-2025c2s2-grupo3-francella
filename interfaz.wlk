import ingredientes.*
object pedido {
    var ultimaPizzaPedida = null

    method ultimaPizzaPedida(nombreDePizza) {
        ultimaPizzaPedida = nombreDePizza
    }

    method position() {
        return game.at(2, 6)
    }

    method text() {
		return ultimaPizzaPedida
	}

	method textColor() {
		return "00000000"
	}

    // aca vamos a tener que usar imagenes pq no hay forma de manipular el tamaño del texto
}


// Gamestate visuals ----------------------------------------------------------------------


object gameOver {
    var property position = game.origin() 

    method image() {
        return "youDied.png"
    }
}

object gameWin {
    var property position = game.origin()

    method image() {
        return "winPlaceholder.png"
    } 
}


// Visualizacion de ingredientes en zoom de mesada ----------------------------------------


object ingredientesEnInterfaz {
    const ingredientesEnInterfaz = #{}

    method mostrarIngredienteEnInterfaz(ingrediente) {
        ingredientesEnInterfaz.add(ingrediente.visualizacionEnInterfaz())
        game.addVisual(ingrediente.visualizacionEnInterfaz())
    }

    method limpiarIngredientesEnInterfaz() {
        ingredientesEnInterfaz.forEach({visual => game.removeVisual(visual)})
        ingredientesEnInterfaz.clear()
    }
}


class IngredienteInterfaz {
    var property position = game.at(0,1)
    
    method image()
}


object salsaInterfaz inherits IngredienteInterfaz {

    override method image() {
        return "salsaInterfaz.png"
    }
}

object quesoInterfaz inherits IngredienteInterfaz {

    override method image() {
        return "quesoInterfaz.png"
    }
}

object masaInterfaz inherits IngredienteInterfaz {
    
    override method image() {
        return "masaInterfaz.png"
    }
}

object tomateInterfaz inherits IngredienteInterfaz {

    override method image() {
        return "tomateInterfaz.png"
    }
}

object jamonInterfaz inherits IngredienteInterfaz {

    override method image() {
        return "jamonInterfaz.png"
    }
}

object cebollaInterfaz inherits IngredienteInterfaz {

    override method image() {
        return "cebollaInterfaz.png"
    }
}