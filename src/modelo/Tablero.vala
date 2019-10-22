//  Compilar usando 
//  valac --pkg gee-0.8 Tablero.vala 
//  ./Tablero
using Gee;
protected enum Estado {
	GANADO,
	PERDIDO,
	JUGANDO
}

protected errordomain ErrorTipo1{
	ARCHIVO_NO_ENCONTRADO
}

protected errordomain ErrorTipo2{
	NEGATIVOS
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
			}

		}		
	}

	/*
	* Cambia las bombas de lugar, omite el lugar x,y.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	*/
	private void cambiaMinas(int x, int y){
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				this.matriz[i,j].set("mina",false);
			}
		}
		//  for (int i = 0; i < k; i++) {
		//  	int coordenadaX = Random.int_range(0,obtenerFilas());					
		//  	int coordenadaY = Random.int_range(0,obtenerColumnas());
		//  	if (coordenadaX == x && coordenadaY == y){
		//  		i-=1;
		//  	} else if (this.matriz[coordenadaX,coordenadaY]["mina"] == true || estaPresionada(coordenadaX, coordenadaY)){
		//  		i-=1;
		//  	} else {
		//  		this.matriz[coordenadaX,coordenadaY].set("mina", true);
		//  	}

		//  }

	}

	/* Obtiene las filas del tablero.
	@return número de filas.
	*/
	public int obtenerFilas(){
		return this.filas;
	}

	/* Obtiene las columnas del tablero.
	@return número de columnas.
	*/
	public int obtenerColumnas(){
		return this.columnas;
	}

	/*
	* Saber si una casilla (x,y) ya ha sido presionada.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	* @return true si ya ha sido presionada, false de lo contrario.
	*/
	public bool estaPresionada(int x, int y)
	requires (x>=0 && x <=obtenerFilas())
	requires (y>=0 && y<=obtenerColumnas())
	{
		return this.matriz[x,y]["presionado"];
	}


	/* 
	* Presionar casilla (x,y). Escribe un mensaje en pantalla advirtiendo que la casilla ya ha sido presionada en caso de.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.	
	* @return true si se pudo presionar, false de lo contrario. 
	*/
	public bool presionar(int x, int y) throws ErrorTipo1{		
		if (x>=0 && y>=0 && x<obtenerFilas() && y<obtenerColumnas()){
			if(this.matriz[x,y]["presionado"] == false){
				this.matriz[x,y].set("presionado", true);
				return true;
			} else {
				stdout.printf ("\t\tEsa casilla ya está presionada.\n");
				return false;
			}
		} else {			
			try{
				if (x<0 || y<0) throw new ErrorTipo2.NEGATIVOS("No se aceptan coordenadas negativas.");
			} catch (ErrorTipo2 e){
				if (e is ErrorTipo2.NEGATIVOS) {
					stdout.printf ("\t\tError: %s\n", e.message);
				}
			}
			try{
				if (x>=obtenerFilas() || y>= obtenerColumnas()) throw new ErrorTipo1.ARCHIVO_NO_ENCONTRADO("Coordeadas inexistentes.");
			} catch (ErrorTipo1 e){
				if (e is ErrorTipo1.ARCHIVO_NO_ENCONTRADO) {
					stdout.printf ("\t\tError: %s\n", e.message);
				}
			}
		}
		return false;
	}

	/* 
	* Poner bandera en casilla (x,y). Escribe un mensaje en pantalla advirtiendo que la casilla no puede abanderarse en caso de.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	* @return true si se pudo colocar la bandera, false en caso contrario.
	*/
	public bool colocarBandera(int x, int y) {
		if (x>=0 && y>=0 && x<obtenerFilas() && y<obtenerColumnas()){
			if(this.matriz[x,y]["bandera"] == false && !estaPresionada(x,y)){
				this.matriz[x,y].set("bandera", true);
				return true;
			} else {
				stdout.printf ("\t\tNo se puede colocar una bandera.\n");
				return false;
			}			
		} else {			
			try{
				if (x<0 || y<0) throw new ErrorTipo2.NEGATIVOS("No se aceptan coordenadas negativas.");
			} catch (ErrorTipo2 e){
				if (e is ErrorTipo2.NEGATIVOS) {
					stdout.printf ("\t\tError: %s\n", e.message);
				}
			}
			try{
				if (x>=obtenerFilas() || y>= obtenerColumnas()) throw new ErrorTipo1.ARCHIVO_NO_ENCONTRADO("Coordeadas inexistentes.");
			} catch (ErrorTipo1 e){
				if (e is ErrorTipo1.ARCHIVO_NO_ENCONTRADO) {
					stdout.printf ("\t\tError: %s\n", e.message);
				}
			}
		}
		return false;
	}

	/* Computa el estado del juego actual 
	* @return estado del juego.
	*/
	public Estado getEstado() {
		// TODO computar el estado actual
		return Estado.GANADO;
	}

	//  public static void main(string[] args) {
	//  	Tablero tabla = new Tablero(11,6,10);
	//  	try{
	//  		/* Sin el try catch el programa tiene warnings. Probar las coordenadas deseadas. */
	//  		tabla.presionar(5,0);		
	//  		tabla.presionar(5,0);		
	//  		tabla.colocarBandera(2,3);
	//  		tabla.presionar(89,-5);
	//  	} catch (ErrorTipo1 e){
	//  	}
	//  }
}