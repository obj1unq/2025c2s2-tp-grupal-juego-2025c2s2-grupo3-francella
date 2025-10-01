import wollok.vm.*
import ingredientes.*

object pizzaMuzzarella {
    const ingredientesNecesarios = #{prepizza, salsa, queso}

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
}

object pizzaNapolitana {
    const ingredientesNecesarios = pizzaMuzzarella.ingredientesNecesarios() + #{tomate, jamon}

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
}

object pizzaCebolla {
    const ingredientesNecesarios = pizzaMuzzarella.ingredientesNecesarios() + #{cebolla}

    method ingredientesNecesarios() {
        return ingredientesNecesarios
    }
}