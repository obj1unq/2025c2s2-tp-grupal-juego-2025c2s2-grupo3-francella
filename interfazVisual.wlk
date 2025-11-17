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
        sonidoPlop.reproducir()
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

object harinaInterfaz inherits IngredienteInterfaz {
    
    override method nombre() {
        return "harina"
    }
}
object aguaInterfaz inherits IngredienteInterfaz {
    
    override method nombre() {
        return "agua"
    }
}
object levaduraInterfaz inherits IngredienteInterfaz {
    
    override method nombre() {
        return "levadura"
    }
}

// Visualizacion de item una vez agarrado en el inventario -------------------------------

object interfazInventario {                               //Interfaz del inventario, usada para mostrar que ingrediente tiene Francella en mano
    var contenidoAMostrar = blank                       //Inicializa en blank, no mostrando ningún ingrediente en absoluto

    method position() {
        return game.at(1,7)
    }

    method image() {
        return contenidoAMostrar.image()
    }

    method cambiarContenidoMostrado(contenidoNuevo) {   //Metodo para cambiar el ingrediente mostrado, use una variable y no preguntarle a 
        contenidoAMostrar = contenidoNuevo              //Francella ya que es posible que Francella no tenga ingredienes, aunque no se
    }                                                       //descarta el posible uso de condicionales para ese caso

    method borrarContenidoMostrado() {                    //Deja en blanco el inventario, usado para casos en que el ingrediente no se
        contenidoAMostrar = blank                         //intercambia, como por ejemplo colocarlo en la mesada o borrarlo
    }
}

object blank {
    method image() {
        return "blank.png"
    }
}




