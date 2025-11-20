import wollok.game.*

//Randomizer que usabamos en las primeras versiones del juego para que los ingredientes spawneen aleatoriamente. No deberiamos borrarlo por si necesitamos usarlo en un futuro.

object randomizer {
		
	method position() {
		return 	game.at( 
					(10 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
	
}