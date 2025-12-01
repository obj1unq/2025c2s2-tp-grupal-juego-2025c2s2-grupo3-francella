import ingredientes.*
import interfazVisual.*
import pizzeria.*
import wollok.game.*


// Comidas armables -------------------------------------------------------------------

class Comida {

    method puedeAgarrarse() {} 
    //Usado para recibir el mensaje desde Francella

    method tiposDe(ingredientesAnalizados) { 
    //Usado para acceder a los tipos de ingredientes y permitir la comparación
        return ingredientesAnalizados.map({ingrediente => ingrediente.tipoIngrediente()}).asSet()
    }
}

//Pizza (armable desde la mesada de pizza) -----------------------
object pizza inherits Comida {
    //Atributos
    const ingredientes = #{} 

    //Set de ingredientes que componen la pizza
    var property estaCocinada = false 
    //Indica si la pizza ya fue cocinada

    method nombre() {
        return "pizza"
    }

    //Metodos lookup
    method ingredientes() {
        return ingredientes
    }

    //Metodos funcionales
    method agregarIngredientes(unosIngredientes) { 
    //Sirve para agregar ingredientes a la pizza a la hora de sacarla de la mesada de la cocina
        ingredientes.addAll(unosIngredientes)
    }

    method entregarPizza() { 
    //Sirve para reiniciar la pizza una vez entregada al cliente
        ingredientes.clear()
    }

    //Booleanos

    method coincideCon(unaPizza) { 
    //Compara si la pizza cocinada coincide con la pizza pedida por el cliente, que la recibe por parametro
        return unaPizza.ingredientesNecesarios() == self.tiposDe(ingredientes)
    }
}

//Masa (armable desde la mesada de masa) -------------------------
object masa inherits Comida {
    //Atributos

    const recetaDeMasa = #{harina, agua, levadura} 
    //Set de ingredientes necesarios para armar la masa

    method nombre() {
        return "masa"
    }

    //Metodos game

    method position(_position) {}

    //Metodos funcionales

    method tipoIngrediente() { 
    //Sirve a la hora de pedir su tipo
        return self
    }

    method visualizacionEnInterfaz() { 
    //Sirve para obtener la interfaz visual de la masa
        return masaInterfaz
    }

    //Booleanos
    
    method hayIngredientesNecesariosEn(ingredientesEncima) { 
    //Sirve a la hora de chequear si los ingredientes encima de la mesada de la sección de amasado son los necesarios para armar la masa
        return recetaDeMasa == self.tiposDe(ingredientesEncima)
    }
}

//El objeto tipos de pizzas será usado para que los clientes sepan cuales tipos de pizzas existen y elegir uno de ellos
object tiposDePizzas {
    const disponibles = #{pizzaMuzzarella, pizzaNapolitana, pizzaFugazzaConQueso}

    method disponibles() {
        return disponibles
    }
}

class Pizzas {
    const ingredientesNecesarios = #{masa, queso}

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza "
    }
}

/*Cada pizza es un objeto, el cual los clientes iran chequeando con la pizza 
cocinada que Franchella haya hecho para comprobar si es efectivamente lo pedido. 
Al ser cada ingrediente una instancia de una clase y no un objeto bien definido 
se trabajará con la clase de los ingredientes usados.*/

object pizzaMuzzarella inherits Pizzas {

    override method ingredientesNecesarios() {
        return super() + #{salsa}
    }

    override method nombreDeLaPizza() {
        return super() + "de muzzarella"
    }
}

object pizzaNapolitana inherits Pizzas {

    override method ingredientesNecesarios() {
        return super() + #{salsa, tomate, jamon}
    }
    override method nombreDeLaPizza() {
        return super() + "napolitana"
    }
}

object pizzaFugazzaConQueso inherits Pizzas {

    override method ingredientesNecesarios() {
        return super() + #{cebolla}
    }
    override method nombreDeLaPizza() {
        return "Fugazza con queso"
    }
}