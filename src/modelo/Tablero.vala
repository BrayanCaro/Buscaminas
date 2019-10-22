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
	ARCHIVO_NO_ENCONTRADO,
	NEGATIVOS
}

public class Tablero {

	/* Clase interna para crear una celda. */
	private class Celda{
		private int _minasAlrededor;
		private bool _bandera;
		private bool _mina;
		private bool _presionado;

		/* Construye una celda.
		* @param minasAlrededor: número de minas en total de las 8, o menos,  minas que lo rodean
		* @param mina: está minada o no.
		* @param presionado: está presionada o no.
		* @param bandera: tiene una bandera o no.
		*/
		public Celda(int minasAlrededor, bool mina, bool presionado, bool bandera){
			this._minasAlrededor = minasAlrededor;
			this._bandera = bandera;
			this._mina = mina;
			this._presionado = presionado;
		}

		/* Getter y setter de la bandera de la celda. */
		public bool bandera{
			get { return _bandera;}
			set {_bandera = value; }
		}

		/* Getter y setter por si la celda está presionada. */
		public bool presionado {
			get {return _presionado;}
			set {_presionado = value;}
		}

		/* Getter y setter para la mina. */
		public bool mina{
			get{return _mina;}
			set{_mina = value;}
		}

		/* Getter de las minas al rededor de la celda. */
		public int minasAlrededor{
			get{return _minasAlrededor;}
		}

		/* Aumenta en 1 las minas al rededor de la celda- */
		public void aumentaMinas(){
			this._minasAlrededor +=1;
		}
	}

	private Celda[,] tablero;
	private Estado estado;
	private int filas;
	private int columnas;	

	/* tablero de n x m con k minas */
	public Tablero(int n, int m, int k) 
	requires (n>=1)
	requires (m>=1)
	requires (k>=1){
		this.filas = n;
		this.columnas = m;
		this.tablero = new Celda[obtenerFilas(),obtenerColumnas()];
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				this.tablero[i,j] = new Celda(0,false, false, false);
			}
		}
		//  Coloca las bombas en el tablero.
		for (int i = 0; i < k; i++) {
			int coordenadaX = Random.int_range(0,obtenerFilas());					
			int coordenadaY = Random.int_range(0,obtenerColumnas());
			if ((this.tablero[coordenadaX, coordenadaY]).mina){
				i-=1;
			} else {
				(this.tablero[coordenadaX, coordenadaY]).mina = true;
			}
		}		
	}

	/*
	* Cambia las bombas de lugar, omite el lugar x,y.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	* @param k: número de minas.
	*/
	public void cambiaMinas(int x, int y, int k){
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				(this.tablero[i, j]).mina = false;
			}
		}

		for (int i = 0; i < k; i++) {
			int coordenadaX = Random.int_range(0,obtenerFilas());					
			int coordenadaY = Random.int_range(0,obtenerColumnas());
			if (coordenadaX == x && coordenadaY == y){
				i-=1;
			} else if ( (this.tablero[coordenadaX, coordenadaY]).mina || estaPresionada(coordenadaX, coordenadaY)){
				i-=1;
			} else {
				(this.tablero[coordenadaX, coordenadaY]).mina = true;
			}
		}

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
		return (this.tablero[x, y]).presionado;
	}

	/*
	* Comprueba que una casilla sea válida, es decir, que esté dentro del rango de filas y columnas y sea mayor o igual que 0.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	*/
	private bool casillaValida(int x, int y){
		bool valida = true;
		try{
			if (x<0 || y<0) throw new ErrorTipo1.NEGATIVOS("No se aceptan coordenadas negativas.");
		} catch (ErrorTipo1 e){
			if (e is ErrorTipo1.NEGATIVOS) {
				stdout.printf ("\t\tError: %s\n", e.message);
				valida = false;
			}
		}
		try{
			if (x>=obtenerFilas() || y>= obtenerColumnas()) throw new ErrorTipo1.ARCHIVO_NO_ENCONTRADO("Coordeadas inexistentes.");
		} catch (ErrorTipo1 e){
			if (e is ErrorTipo1.ARCHIVO_NO_ENCONTRADO) {
				stdout.printf ("\t\tError: %s\n", e.message);
				valida = false;
			}
		}
		return valida;
	}
	/* 
	* Presionar casilla (x,y). Escribe un mensaje en pantalla advirtiendo que la casilla ya ha sido presionada en caso de.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.	
	* @return true si se pudo presionar, false de lo contrario. 
	*/
	public bool presionar(int x, int y) throws ErrorTipo1{
		if (casillaValida(x, y)){
			if (!(this.tablero[x,y].presionado)){
				this.tablero[x,y].presionado = true;
				return true;
			} else {
				stdout.printf ("\t\tEsa casilla ya está presionada.\n");
				return false;
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
		if (casillaValida(x,y)){
			if(!(this.tablero[x,y].bandera || estaPresionada(x,y))){
				this.tablero[x,y].bandera = true;
				return true;
			} else {
				stdout.printf ("\t\tNo se puede colocar una bandera.\n");
				return false;
			}			
		}
		return false;
	}

	/* Computa el estado del juego actual 
	* @return estado del juego.
	*/
	public Estado getEstado() {
		return this.estado;
	}

	public void setEstado(Estado estado){
		this.estado = estado;
	}

	/*
	* Devuelve el equivalente a una cadena de texto del tablero.
	*/
	public void to_string (){
	}

	public static void main(string[] args) {
		Tablero tabla = new Tablero(11,6,10);
		tabla.cambiaMinas(3,5, 10);
		Celda m = new Celda(2,false, false, false);
		
		stdout.printf ("%s\n", (m.bandera).to_string());
		//  try{
			/* Sin el try catch el programa tiene warnings. Probar las coordenadas deseadas. */
			//  tabla.presionar(5,0);		
			//  tabla.presionar(5,0);		
			//  tabla.colocarBandera(2,3);
			//  tabla.presionar(89,-5);
		//  } catch (ErrorTipo1 e){
		//  }
	}
}
