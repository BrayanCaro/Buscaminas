using Gee;
protected enum Estado {
	GANADO,
	PERDIDO,
	JUGANDO
}

public class Tablero {
	private Gee.HashMap<string, bool>[,] matriz;
	private int filas;
	private int columnas;

	/* tablero de n x m con k minas */
	public Tablero(int n, int m, int k) 
	requires (n>=1)
	requires (m>=1)
	requires (k>=1){
		this.filas = n;
		this.columnas = m;
		this.matriz = new Gee.HashMap<string,bool>[obtenerFilas(),obtenerColumnas()];
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				this.matriz[i,j] = new Gee.HashMap<string,bool>();
				this.matriz[i,j].set("bandera",false);
				this.matriz[i,j].set("mina",false);
				this.matriz[i,j].set("presionado",false);
				//  stdout.printf ("%s %s %s ",(this.matriz[i,j]["bandera"]).to_string(), (this.matriz[i,j]["mina"]).to_string(), (this.matriz[i,j]["presionado"]).to_string());
				//  stdout.printf ("i: %i, j: %i\n", i,j);
			}
		}
		//  Coloca las bombas en el tablero.
		for (int i = 0; i < k; i++) {
			int coordenadaX = Random.int_range(0,obtenerFilas());					
			int coordenadaY = Random.int_range(0,obtenerColumnas());
			if (this.matriz[coordenadaX,coordenadaY]["mina"] == true){
				i-=1;
			} else {
				this.matriz[coordenadaX,coordenadaY].set("mina", true);
				//  stdout.printf ("%i. (%i,%i): %s\n",i, coordenadaX, coordenadaY, (this.matriz[coordenadaX,coordenadaY]["mina"]).to_string());
			}

		}		
	}

	public int obtenerFilas(){
		return this.filas;
	}

	public int obtenerColumnas(){
		return this.columnas;
	}

	public bool estaPresionada(int x, int y)
	requires (x>=0 && x <=obtenerFilas())
	requires (y>=0 && y<=obtenerColumnas())
	{
		return this.matriz[x,y]["presionado"];
	}


	/* presionar casilla (x,y) */
	public bool presionar(int x, int y) 
	requires (x>=0 && x <=obtenerFilas())
	requires (y>=0 && y<=obtenerColumnas()){	
		if(this.matriz[x,y]["presionado"] == false){
			this.matriz[x,y].set("presionado", true);
			return true;
		} else {
			stdout.printf ("\t\tEsa casilla ya está presionada.\n");
			return false;
		}
	}

	/* poner bandera en casilla (x,y) */
	public bool colocarBandera(int x, int y)
	requires (x>=0 && x <obtenerFilas())
	requires (y>=0 && y<obtenerColumnas()) {
		if(this.matriz[x,y]["bandera"] == false && !estaPresionada(x,y)){
			this.matriz[x,y].set("bandera", true);
			return true;
		} else {
			stdout.printf ("\t\tNo se puede colocar una bandera.\n");
			return false;
		}
	}

	/* computa el estado del juego actual */
	public Estado getEstado() {
		// TODO computar el estado actual
		return Estado.GANADO;
	}

	public static void main(string[] args) {
		Tablero tabla = new Tablero(11,6,10);	
		//  tabla.presionar(5,0);
		//  tabla.presionar(0,0);
		//  tabla.colocarBandera(2,3);
		//  tabla.colocarBandera(5,0);
		//  tabla.colocarBandera(89,-5);

	}
}
