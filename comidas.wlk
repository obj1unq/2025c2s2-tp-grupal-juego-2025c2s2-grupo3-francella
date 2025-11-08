import ingredientes.*
import interfazVisual.*
import pizzeria.*
import wollok.game.*


// Comidas armables -------------------------------------------------------------------

class Comida {
  const ingredientes = []

  method puedeAgarrarse() {}

  method ingredientes() {
    return ingredientes
  }
  
  method ingredientesUsados() {
    return ingredientes.map({ingrediente => ingrediente.tipoIngrediente()})
  }

  method agregarIngrediente(unIngrediente) {
    ingredientes.add(unIngrediente)
  }
}

object pizza inherits Comida {
  var property estaCocinada = false

  override method puedeAgarrarse() {
      return ingredientes.size() > 0
  }

  method entregarPizza() {
      ingredientes.clear()
  }

  method coincideCon(unaPizza) {
    return unaPizza.ingredientesNecesarios() == ingredientes
  }
}

object masa inherits Comida {
    const recetaDeMasa = [harina, agua, levadura]

    override method puedeAgarrarse() {
        return ingredientes.size() == recetaDeMasa.size()
    }

    method tipoIngrediente() {
        return self
    }
    
    method spawn() {
        const nuevaMasa = new Masa(position = mesadaParaMasa.position())
        game.addVisual(nuevaMasa)
        ingredientes.agregarACocina(nuevaMasa)
    }

    method coincideCon() {
        return recetaDeMasa == ingredientes
    }

    method visualizacionEnInterfaz() {
        return masaInterfaz
    }
}

//El objeto tipos de pizzas será usado para que los clientes sepan cuales tipos de pizzas existen y elegir uno de ellos
object tiposDePizzas {
    const disponibles = #{pizzaMuzzarella, pizzaNapolitana, pizzaCebolla}

    method disponibles() {
        return disponibles
    }
}

//Cada pizza es un objeto, el cual los clientes iran chequeando con la pizza cocinada que Franchella haya hecho para comprobar si es efectivamente lo pedido. Al ser cada ingrediente una instancia de una clase y no un objeto bien definido se trabajará con la clase de los ingredientes usados
object pizzaMuzzarella {
    const ingredientesNecesarios = [masa, salsa, queso] // NO DEBERÍAN SER STRINGS

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza de Mozzarella"
    }
}

object pizzaNapolitana {
    const ingredientesNecesarios = pizzaMuzzarella.ingredientesNecesarios() + [tomate, jamon]

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza Napolitana"
    }
}

object pizzaCebolla {
    const ingredientesNecesarios = pizzaMuzzarella.ingredientesNecesarios() + [cebolla]

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
    method nombreDeLaPizza() {
        return "Pizza de Cebolla"
    }
}