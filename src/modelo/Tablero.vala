namespace Tablero { 

public errordomain ParametrosInvalidos {
	MUY_CHICO,
	MUY_GRANDE
}


protected enum Estado {
	GANADO,
	PERDIDO,
	JUGANDO
}

public class Tablero {
	private Gee.HashMap<string, bool>[,] matriz;

	/* tablero de n x m con k minas */
	public Tablero(int n, int m, int k) throws ParametrosInvalidos {
		/* comprueba que los parametros tengan sentido */
		if (n < 1 || m < 1 || k < 1)
			throw new ParametrosInvalidos.MUY_CHICO("Muy chico");


		this.matriz = new Gee.HashMap<string, bool>[n,m];
		for (int i = 0; i < n; i++)
			for (int j = 0; j < m; j++) {
				this.matriz[n,m] = new Gee.HashMap<string, bool>();
				this.matriz[n,m].set("bandera", false);
				this.matriz[n,m].set("mina", false);
				this.matriz[n,m].set("presinado", false);
			}

		// TODO colocar bombas en el tablero
	}

}

	/* presoinar casilla (x,y) */
	public void presionar(int x, int y, int n) {
		/* comprueba que los parametros tengan sentido */
		if (x < 0 || x >= n || x < 0 || y >= 0)
			throw new ParametrosInvalidos.MUY_CHICO("Muy chico");

		// TODO presionar casilla
	}

	/* poner bandera en casilla (x,y) */
	public void colocarBandera(int x, int y, int n) {
		/* comprueba que los parametros tengan sentido */
		if (x < 0 || x >= n || x < 0 || y >= 0)
			throw new ParametrosInvalidos.MUY_CHICO("Muy chico");

		// TODO colocar bandera
	}

	/* computa el estado del juego actual */
	public Estado getEstado() {
		// TODO computar el estado actual
		return Estado.GANADO;
	}
}