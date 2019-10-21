protected enum Estado {
	GANADO,
	PERDIDO,
	JUGANDO
}

public class Tablero {
	private Gee.HashMap<string, bool>[,] matriz;

	/* tablero de n x m con k minas */
	public Tablero(int n, int m, int k) 
	requires (n>=1)
	requires (m>=1)
	requires (k>=1){
		/* comprueba que los parametros tengan sentido */

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

	/* presoinar casilla (x,y) */
	public void presionar(int x, int y) 
	requires (x>0 && x <=10)
	requires (y>0 && y<=10){
		/* comprueba que los parametros tengan sentido */
		//  Cambiar el 10 por el número máximo de filas y columnas.

		// TODO presionar casilla
	}

	/* poner bandera en casilla (x,y) */
	public void colocarBandera(int x, int y)
	requires (x>0 && x <=10)
	requires (y>0 && y<=10) {
		//  Cambiar el 10 por el número máximo de filas y columnas.
		/* comprueba que los parametros tengan sentido */

		// TODO colocar bandera
	}

	/* computa el estado del juego actual */
	public Estado getEstado() {
		// TODO computar el estado actual
		return Estado.GANADO;
	}

	public static void main(string[] args) {
		//  print("Hola Mudno \n");
	}
}
