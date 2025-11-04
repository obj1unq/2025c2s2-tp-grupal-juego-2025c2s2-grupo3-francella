import ingredientes.*
import audio.*


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
        return "gameOverPlaceholder.png"
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
        pizzaPlop.reproducir()
    }

    method limpiarIngredientesEnInterfaz() {
        ingredientesEnInterfaz.forEach({visual => game.removeVisual(visual)})
        ingredientesEnInterfaz.clear()
        armarPizza.reproducir()
    }
}


class IngredienteInterfaz {
    var property position = game.origin()
    
    method nombre()

    method image() {
        return self.nombre() + "Interfaz.png"
    }
}


object salsaInterfaz inherits IngredienteInterfaz {

    override method nombre() {
        return "salsa"
    }
}

object quesoInterfaz inherits IngredienteInterfaz {

    override method nombre() {
        return "queso"
    }
}

object masaInterfaz inherits IngredienteInterfaz {
    
    override method nombre() {
        return "masa"
    }
}

object tomateInterfaz inherits IngredienteInterfaz {

    override method nombre() {
        return "tomate"
    }
}

object jamonInterfaz inherits IngredienteInterfaz {

    override method nombre() {
        return "jamon"
    }
}

object cebollaInterfaz inherits IngredienteInterfaz {

    override method nombre() {
        return "cebolla"
    }
}