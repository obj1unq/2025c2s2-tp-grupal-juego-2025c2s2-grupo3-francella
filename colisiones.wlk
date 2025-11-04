class Colision {
    var property position

    method image() {
        return "blank.png"
    }
}

object colisiones {
    const celdasConColision = #{}

    method establecerNuevaColision(_position) {
        const nuevaColision = new Colision (position = _position)
        celdasConColision.add(_position)
        game.addVisual(nuevaColision)
    }

    method hayColisionEn(celda) {
        return celdasConColision.contains(celda)
    }
}

object _{
    method dibujar(position) {

    }
}

object c{

    method dibujar(position) {
        colisiones.establecerNuevaColision(position)
    }

}

object mapaDeColisiones {
    const dibujo =[
        [ _, _, _, _, _, c, c, _, _, _, _, _, _, _, _, _ ],
        [ _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ ],
        [ _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _ ],
        [ _, _, _, _, _, c, _, c, c, c, _, c, c, c, _, c ],
        [ _, _, _, _, _, _, _, _, c, _, _, _, c, _, _, _ ],
        [ _, _, _, _, _, _, _, _, c, _, _, _, c, _, _, _ ],
        [ _, _, _, _, _, _, _, _, c, _, _, _, c, _, _, _ ],
        [ _, _, _, _, _, _, _, _, c, _, _, _, c, _, _, _ ]
    ].reverse()

    method establecerColisiones() {
        game.height(dibujo.size()) //configuro el alto segun la cantidad de filas del dibujo
        game.width(dibujo.anyOne().size()) //configuro el ancho segun la cantidad de columnas del dibujo
        //itero por el ancho y luego por el alto.
        (0 .. game.width() - 1).forEach({ x => 
            (0 .. game.height() - 1).forEach({y => 
                dibujo.get(y).get(x).dibujar(game.at(x,y))  //obtengo el dibujante de la cordenada que corresponde a la iteracion y le pido que dibuje en esa cordenada
            })
        })
    }
}