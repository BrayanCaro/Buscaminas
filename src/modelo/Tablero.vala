//  Compilar usando 
//  valac Tablero.vala 
//  ./Tablero
protected enum Estado {
	GANADO,
	PERDIDO,
	JUGANDO
}

protected errordomain ErrorTipo1{
	ARCHIVO_NO_ENCONTRADO,
	NEGATIVOS
}

/* Tablero del buscaminas. */
public class Tablero {
	private Celda[,] tablero;
	private Estado estado;
	private int filas;
	private int columnas;
	private int minas;
	private int contadorParaGanar;

	const string reset = "\033[0m";
	const string letraNegra = "\033[1;30m";
	const string fondoBlanco = "\033[47m";
	const string fondoVerde = "\033[42m";
	const string fondoVerdeIntenso = "\033[0;102m";

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
			set{_minasAlrededor = value;}
		}

		/* Aumenta en 1 las minas al rededor de la celda- */
		public void aumentaMinas(){
			this._minasAlrededor +=1;
		}

		/* Convierte en una cadena de texto la información de la celda. */
		public string to_string(){
			string s = "";
			if (!presionado && !bandera){
				s = fondoVerdeIntenso+letraNegra+"[  ]"+reset;
				s = "[?]"+reset;
			} else if (presionado && mina){
				s = fondoVerdeIntenso+letraNegra+"[💣]"+reset;
				s = "[B]"+reset;
			} else if (bandera){
				s = fondoVerdeIntenso+letraNegra+"[🚩]"+reset;
				s = "[F]"+reset;
			} else {
				if (this._minasAlrededor == 0) s = "[ ]";
				else s = "[" + this._minasAlrededor.to_string() + "]"+reset;
			}

			/*
			if (mina){
				s = fondoVerdeIntenso+letraNegra+"[💣]"+reset;
				s = "[B]"+reset;
			} else {
				s = fondoVerde+letraNegra+"[  ]"+reset;
				s = "[" + this._minasAlrededor.to_string() + "]"+reset;
			} 
			*/
			return s;
		}
	}


	/* tablero de n x m con k minas */
	public Tablero(int n, int m, int k) 
	requires (n>=1)
	requires (m>=1)
	requires (k>=1){
		this.filas = n;
		this.columnas = m;
		this.minas = k;
		this.tablero = new Celda[obtenerFilas(),obtenerColumnas()];
		setEstado(Estado.JUGANDO);
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

		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				this.tablero[i,j].minasAlrededor = actualizaMinasAlrededor(i,j);
			}
		}
	}

	/* Obtiene todas las minas del tablero.
	* @return número de minas.
	*/
	public int obtenerMinas(){
		return this.minas;
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
	
	/* Revela todas las minas del tablero. */
	private void revelaMinas(){
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				tablero[i,j].presionado = true;
			}
		}
	}

	/* Cambia las bombas de lugar, omite el lugar x,y.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	* @param k: número de minas.
	*/
	public void cambiaMinas(int x, int y){
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				(this.tablero[i, j]).mina = false;
			}
		}

		for (int i = 0; i < obtenerMinas(); i++) {
			int coordenadaX = Random.int_range(0,obtenerFilas());					
			int coordenadaY = Random.int_range(0,obtenerColumnas());
			if (coordenadaX == x && coordenadaY == y){
				i-=1;
			} else if ( (this.tablero[coordenadaX, coordenadaY]).mina || tablero[x,y].presionado){
				i-=1;
			} else {
				(this.tablero[coordenadaX, coordenadaY]).mina = true;
			}
		}

	}

	/* Comprueba que una casilla sea válida, es decir, que esté dentro del rango de filas y columnas y sea mayor o igual que 0.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	*/
	private bool casillaValida(int x, int y){
		bool valida = true;
		try{
			if (x<0 || y<0) throw new ErrorTipo1.NEGATIVOS("No se aceptan coordenadas negativas.");
		} catch (ErrorTipo1 e){
			if (e is ErrorTipo1.NEGATIVOS) {
				// stdout.printf ("\t\t"+letraNegra+"Error: %s\n", e.message);
				valida = false;
			}
		}
		try{
			if (x>=obtenerFilas() || y>= obtenerColumnas()) throw new ErrorTipo1.ARCHIVO_NO_ENCONTRADO("Coordeadas inexistentes.");
		} catch (ErrorTipo1 e){
			if (e is ErrorTipo1.ARCHIVO_NO_ENCONTRADO) {
				// stdout.printf ("\t\t"+letraNegra+"Error: %s\n", e.message);
				valida = false;
			}
		}
		return valida;
	}

	/* Presionar casilla (x,y). Escribe un mensaje en pantalla advirtiendo que la casilla ya ha sido presionada en caso de.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.	
	* @return true si se pudo presionar, false de lo contrario. 
	*/
	public bool presionar(int x, int y) throws ErrorTipo1{
		if (casillaValida(x, y)){
			if (!(this.tablero[x,y].presionado)){	
				if (tablero[x,y].mina){
				this.tablero[x,y].presionado = true;
				revelaMinas();
				setEstado(Estado.PERDIDO);
				} else{ // No hay una mina en la casilla.
					this.tablero[x,y].presionado = true;
					setEstado(Estado.JUGANDO);
					contadorParaGanar+=1;
					this.extender(x,y);
				}
				if (contadorParaGanar == (obtenerFilas()*obtenerColumnas())-obtenerMinas()-1){
					setEstado(Estado.GANADO);
				}
				return true;
			} else {
				stdout.printf ("\t\t"+letraNegra+"Esa casilla ya está presionada.\n");
				return false;
			}
		} 
		return false;
	}

	private int actualizaMinasAlrededor(int x, int y) {
		int total = 0;
		int[,] coords = { {x, y+1}, {x-1, y}, {x+1, y}, {x, y-1},
			{x+1, y+1}, {x+1, y-1}, {x-1, y-1}, {x-1, y+1} };
		for (int k = 0; k < coords.length[0]; k++) {
			int i = coords[k,0];
			int j = coords[k,1];
			if (casillaValida(i,j)) {
				if (this.tablero[i,j].mina)
					total += 1;
			}
		}
		return total;
	}

	/* extiende al presionar una casilla a todas las vecinas que no esten ya
	 * presionadas o con alguna mina o bandera */
	private void extender(int x, int y) {
		if (this.tablero[x,y].minasAlrededor > 0)
			return;

		int[,] coords = { {x, y+1}, {x-1, y}, {x+1, y}, {x, y-1} };
		for (int k = 0; k < coords.length[0]; k++) {
			int i = coords[k,0];
			int j = coords[k,1];
			if (casillaValida(i,j)) {
				Celda c = this.tablero[i,j];
				if (!c.mina && !c.bandera && !c.presionado) {
					this.tablero[i,j].presionado = true;
					stdout.printf("(%d,%d) llamando (%d,%d)\n", x, y, i, j);
					this.extender(i,j);
				}
			}
		}
	}

	/* Poner o quitar bandera en casilla (x,y). Escribe un mensaje en pantalla advirtiendo que la casilla no puede abanderarse en caso de.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	* @return true si se pudo colocar o quitar la bandera, false en caso contrario.
	*/
	public bool colocarBandera(int x, int y) {
		if (casillaValida(x,y)){
			if(!(this.tablero[x,y].bandera || tablero[x,y].presionado)){
				this.tablero[x,y].bandera = true;
				setEstado(Estado.JUGANDO);
				return true;
			} 
			if (tablero[x,y].bandera && !tablero[x,y].presionado){
				tablero[x,y].bandera = false;
				setEstado(Estado.JUGANDO);
				return true;
			} else 
			if (tablero[x,y].presionado){
				stdout.printf ("\t\t"+letraNegra+"No se puede colocar una bandera.\n");
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

	/* Establece el estado del juego.
	* @param estado: Estado del juego.
	*/
	public void setEstado(Estado estado){
		this.estado = estado;
	}

	/* Devuelve el equivalente a una cadena de texto del tablero. */
	public void to_string (){
		print("\n");
		for (int i = 0; i < obtenerColumnas(); i++) {
			if (i == 0) stdout.printf ("\t\t\t %i ",i);
			else 
			if (i>9) stdout.printf ("%i ",i);
			else stdout.printf (" %i ",i);
		}

		print("\n");
		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				if (j == 0){
					stdout.printf ("\t\t\t"+tablero[i,j].to_string());
				} else {
					stdout.printf (tablero[i,j].to_string());
				}
			}
			stdout.printf (" %i ",i);
			print("\n");
		}	
		print("\n"+reset);
	}
}