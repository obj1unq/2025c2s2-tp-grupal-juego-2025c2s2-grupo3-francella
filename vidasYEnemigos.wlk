//Sistema de vidas-----------------------------------------------------------

object sistemaVidas {
    var vidasLlenas = 3

    method position() {
        return game.at(4,8)
    }

    method image() {
        return "corazones" + vidasLlenas.toString() + ".png"
    }

    method perderUnaVida() {
        vidasLlenas -= 1
    }

    method vidasLlenas() {
        return vidasLlenas
    }
}