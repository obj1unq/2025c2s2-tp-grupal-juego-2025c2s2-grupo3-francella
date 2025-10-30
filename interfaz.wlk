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

    // necesitaríamos un method textSize() {}, pero si existe, no sé cómo se llama
}