import ingredientes.*
import audio.*


object pedido { //Objeto que muestra en la interfaz visual el pedido del cliente actual
    var ultimaPizzaPedida = null //Guarda el nombre de la última pizza pedida para mostrarla en la interfaz

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


object gameOver { //Estado Gameover cuando Francella entrega mal una pizza
    var property position = game.origin() 

    method image() {
        return "gameOverPlaceholder.png"
    }
}

object gameWin { //Estado Gamewin cuando Francella entrega correctamente la pizza
    var property position = game.origin()

    method image() {
        return "gameWinPlaceholder.png"
    } 
}


// Visualizacion de ingredientes en zoom de mesada ----------------------------------------


object ingredientesEnInterfaz { //Objeto encargado de mostrar los ingredientes en la interfaz visual de la mesada
    const ingredientesEnInterfaz = #{} //Set de ingredientes que se están mostrando en la interfaz

    method mostrarIngredienteEnInterfaz(ingrediente) { //Agrega un ingrediente a la interfaz visual
        ingredientesEnInterfaz.add(ingrediente.visualizacionEnInterfaz())
        game.addVisual(ingrediente.visualizacionEnInterfaz())
        sonidoPlop.reproducir()
    }

    method limpiarIngredientesEnInterfaz() { //Limpia todos los ingredientes que se están mostrando en la interfaz visual
        ingredientesEnInterfaz.forEach({visual => game.removeVisual(visual)})
        ingredientesEnInterfaz.clear()
        armarPizza.reproducir()
    }
}


class IngredienteInterfaz { //Clase abstracta que sirve como superclase para las visualizaciones de cada ingrediente en la interfaz de mesada
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

object interfazInventario { //Interfaz del inventario, usada para mostrar que ingrediente tiene francella en mano. Se usa un objeto aparte para considerar el caso en que francella no tenga objeto en mano
    var contenidoAMostrar = vacio  //Inicializa en blank, no mostrando ningún ingrediente en absoluto.

    method position() {
        return game.at(1,7)
    }

    method image() {
        return contenidoAMostrar.image() //Muestra la imagen del ingrediente que tiene francella en mano
    }

    method cambiarContenidoMostrado(contenidoNuevo) {   //Metodo para cambiar el ingrediente mostrado en la interfaz del inventario.
        contenidoAMostrar = contenidoNuevo              
    }                                                       

    method borrarContenidoMostrado() {  //Deja en blanco el inventario, usado para casos en que el ingrediente no se
        contenidoAMostrar = vacio                         
    }
}

object vacio { //Objeto "vacio" utilizado para representar un objeto vacio, tanto para la interfaz del inventario como para otros posibles usos.
    method image() {
        return "blank.png"
    }
}




