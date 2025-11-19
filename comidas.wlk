import ingredientes.*
import interfazVisual.*
import pizzeria.*
import wollok.game.*


// Comidas armables -------------------------------------------------------------------

class Comida {
    const ingredientes = #{}

    method puedeAgarrarse() {}

    method ingredientes() {
        return ingredientes
    }

    method ingredientesUsados() {
    return ingredientes.map({ingrediente => ingrediente.tipoIngrediente()}).asSet()
    }

    method agregarIngredientes(unosIngredientes) {
        ingredientes.addAll(unosIngredientes)
    }
}

object pizza inherits Comida {
    var property estaCocinada = false

    method image() {
        return "pizza.png"
    }

    method entregarPizza() {
        ingredientes.clear()
    }

    method coincideCon(unaPizza) {
        return unaPizza.ingredientesNecesarios() == ingredientes
    }
}

object masa inherits Comida {
    const recetaDeMasa = #{harina, agua, levadura}

    method image() {
        return "masa.jpg"
    }

    method position(_position) {}

    method tipoIngrediente() {
        return self
    }

    method visualizacionEnInterfaz() {
        return masaInterfaz
    }

    method hayIngredientesNecesariosEn(ingredientesEncima) {
        return recetaDeMasa == self.tiposDe(ingredientesEncima)
    }

    method tiposDe(ingredientesAnalizados) {
        return ingredientesAnalizados.map({ingrediente => ingrediente.tipoIngrediente()}).asSet()
    }

}

//El objeto tipos de pizzas será usado para que los clientes sepan cuales tipos de pizzas existen y elegir uno de ellos
object tiposDePizzas {
    const disponibles = #{pizzaMuzzarella, pizzaNapolitana, pizzaCebolla}

    method disponibles() {
        return disponibles
    }
}

class Pizzas {
    const ingredientesNecesarios = [masa, salsa, queso]

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza "
    }
}
//Cada pizza es un objeto, el cual los clientes iran chequeando con la pizza 
//cocinada que Franchella haya hecho para comprobar si es efectivamente lo pedido. 
//Al ser cada ingrediente una instancia de una clase y no un objeto bien definido 
//se trabajará con la clase de los ingredientes usados.

object pizzaMuzzarella inherits Pizzas {

    override method nombreDeLaPizza() {
        return super() + "de Muzzarella"
    }
}

object pizzaNapolitana inherits Pizzas {

    override method ingredientesNecesarios() {
        return super() + [tomate, jamon]
    }
    override method nombreDeLaPizza() {
        return super() + "Napolitana"
    }
}

object pizzaCebolla inherits Pizzas {

    override method ingredientesNecesarios() {
        return super() + [cebolla]
    }
    override method nombreDeLaPizza() {
        return super() + "de Cebolla"
    }
}