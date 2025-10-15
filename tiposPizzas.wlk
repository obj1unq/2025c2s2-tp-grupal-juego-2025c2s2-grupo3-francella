import wollok.game.*
import ingredientes.*


//El objeto tipos de pizzas será usado para que los clientes sepan cuales tipos de pizzas existen y elegir uno de ellos
object tiposDePizzas {
    const disponibles = #{pizzaMuzzarella, pizzaNapolitana, pizzaCebolla}

    method disponibles() {
        return disponibles
    }
}

//Cada pizza es un objeto, el cual los clientes iran chequeando con la pizza cocinada que Franchella haya hecho para comprobar si es efectivamente lo pedido. Al ser cada ingrediente una instancia de una clase y no un objeto bien definido se trabajará con la clase de los ingredientes usados
object pizzaMuzzarella {
    const ingredientesNecesarios = ["prepizza", "salsa", "queso"]

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza de Mozzarella"
    }
}

object pizzaNapolitana {
    const ingredientesNecesarios = pizzaMuzzarella.ingredientesNecesarios() + ["tomate", "jamon"]

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza Napolitana"
    }
}

object pizzaCebolla {
    const ingredientesNecesarios = pizzaMuzzarella.ingredientesNecesarios() + ["cebolla"]

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza de Cebolla"
    }
}