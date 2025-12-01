import ingredientes.*
import audio.*
import francella.*
import pizzeria.*


object pedido { 
//Objeto que muestra en la interfaz visual el pedido del cliente actual

    var ultimaPizzaPedida = vacio 
    //Guarda el nombre de la última pizza pedida para mostrarla en la interfaz, por defecto está vacia.

    method ultimaPizzaPedida(nombreDePizza) {
        ultimaPizzaPedida = nombreDePizza
    }

    method position() {
        return game.at(0, 6)
    }

    method image() {
		return "pedido" + ultimaPizzaPedida + ".png"
	}
}


// Sistema de vidas:
// Sistema de vidas rudimentario que está desacoplado de francella. En futuras versiones puede ser modelado para que interactue con francella u otros cambios.

object visualizacionVidaJugador {
    var jugador = francella

    method position() {
        return game.at(2,7)
    }

    method image() {
        return "corazones" + jugador.vida().toString() + ".png"
    }
}


// Gamestate visuals ----------------------------------------------------------------------


object gameOver { 
//Estado Gameover cuando Francella entrega mal una pizza

    var property position = game.origin() 

    method image() {
        return "gameOverPlaceholder.png"
    }
}

object gameWin { 
//Estado Gamewin cuando Francella entrega correctamente la pizza

    var property position = game.origin()

    method image() {
        return "gameWinPlaceholder.png"
    } 
}


// Visualizacion de ingredientes en zoom de mesada ----------------------------------------


object ingredientesEnInterfaz { 
//Objeto encargado de mostrar los ingredientes en la interfaz visual de la mesada

    const ingredientesEnInterfaz = #{} 
    //Set de ingredientes que se están mostrando en la interfaz

    method mostrarIngredienteEnInterfaz(ingrediente) { 
    //Agrega un ingrediente a la interfaz visual
        ingredientesEnInterfaz.add(ingrediente.visualizacionEnInterfaz())
        game.addVisual(ingrediente.visualizacionEnInterfaz())
        sonidoPlop.reproducir()
    }

    method limpiarIngredientesEnInterfaz() { 
    //Limpia todos los ingredientes que se están mostrando en la interfaz visual
        ingredientesEnInterfaz.forEach({visual => game.removeVisual(visual)})
        ingredientesEnInterfaz.clear()
        armarPizza.reproducir()
    }
}


class IngredienteInterfaz { 
//Clase abstracta que sirve como superclase para las visualizaciones de cada ingrediente en la interfaz de mesada

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

object interfazInventario { 
//Interfaz del inventario, usada para mostrar que ingrediente tiene francella en mano. Se usa un objeto aparte para considerar el caso en que francella no tenga objeto en mano

    var contenidoAMostrar = manoVacia  
    //Inicializa en blank, no mostrando ningún ingrediente en absoluto.

    method position() {
        return game.at(3,0)
    }

    method image() {
    //Muestra la imagen del ingrediente que tiene francella en mano
        return contenidoAMostrar.nombre() + "Inventario.png"
    }

    method cambiarContenidoMostrado(contenidoNuevo) {   
    //Metodo para cambiar el ingrediente mostrado en la interfaz del inventario.
        contenidoAMostrar = contenidoNuevo              
    }                                                       

    method borrarContenidoMostrado() {  
    //Deja en blanco el inventario, usado para casos en que el ingrediente no se
        contenidoAMostrar = manoVacia                         
    }
}

object manoVacia { 
//Objeto "vacio" utilizado para representar un objeto vacio, tanto para la interfaz del inventario como para otros posibles usos.
    method nombre() {
        return "manoVacia"
    }
}




