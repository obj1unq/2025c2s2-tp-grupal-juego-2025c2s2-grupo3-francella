import game.*

object musicaDeFondo {
    method reproducir(){
        const  musicaDeFondo = game.sound("pizzaTheme.mp3")
        musicaDeFondo.shouldLoop(true)
        musicaDeFondo.volume(0.2)
        musicaDeFondo.play()
    }
}

object pizzaPlop {
    const sonidosAleatorios = #{"plop1.mp3", "plop2.mp3"}

    method reproducir() {
        const nuevoPlop = game.sound(sonidosAleatorios.anyOne())
        nuevoPlop.volume(0.8)
        nuevoPlop.play()
    }
}

object armarPizza {
    method reproducir() {
        const armarPizza = game.sound("armarPizza.wav")
        armarPizza.volume(0.8)
        armarPizza.play()
    }
}