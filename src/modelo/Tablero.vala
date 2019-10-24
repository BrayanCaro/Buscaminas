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
public class Tablero : Object {
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
	private class Celda : Object {
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

		/* Convierte en una cadena de texto la información de la celda. */
		public string to_string(){
			string s = "";
			if (!presionado && !bandera){
				s = fondoVerdeIntenso+letraNegra+"[ ?]"+reset;
				// s = "[?]"+reset;
			} else if (presionado && mina){
				s = fondoVerdeIntenso+letraNegra+"[💣]"+reset;
				// s = "[B]"+reset;
			} else if (bandera){
				s = fondoVerdeIntenso+letraNegra+"[🚩]"+reset;
				// s = "[F]"+reset;
			} else {
				if (this._minasAlrededor == 0) s = fondoVerde+letraNegra+"[  ]"+reset;
				else s = fondoVerde+letraNegra+"[ " + this._minasAlrededor.to_string() + "]"+reset;
			}
			return s;
		}
	}

	/* tablero de n x m con k minas 
	* @param n: filas del tablero.
	* @param m: columnas del tablero.
	* @param k: minas en el tablero.
	*/
	public Tablero(int n, int m, int k) 
	requires (n>=1)
	requires (m>=1)
	requires (k>=1){
		this.filas = n;
		this.columnas = m;
		this.minas = k;
		this.contadorParaGanar = 0;
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
	* @return número de filas.
	*/
	public int obtenerFilas(){
		return this.filas;
	}
	
	/* Obtiene las columnas del tablero.
	* @return número de columnas.
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
	private void cambiaMinas(int x, int y){
		bool bandera = true;
		do {
				int coordenadaX = Random.int_range(0,obtenerFilas());
				int coordenadaY = Random.int_range(0,obtenerColumnas());
				if ((this.tablero[coordenadaX, coordenadaY]).mina || (coordenadaX == x && coordenadaY == y)){
					bandera = true;
				} else {
					(this.tablero[coordenadaX, coordenadaY]).mina = true;
					bandera = false;
				}	
		} while (bandera);

		for (int i = 0; i < obtenerFilas(); i++) {
			for (int j = 0; j < obtenerColumnas(); j++) {
				this.tablero[i,j].minasAlrededor = actualizaMinasAlrededor(i,j);
			}
		}
	}		

	/* Comprueba que una casilla sea válida, es decir, que esté dentro del rango de filas y columnas y sea mayor o igual que 0.
	* @param x: coordenada en el eje x.
	* @param y: coordenada en el eje y.
	* @return true si la casilla es válida, false de lo contrario.
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
	public bool presionar(int x, int y){
		if (casillaValida(x, y)){
			if (!(this.tablero[x,y].presionado)){	
				if (tablero[x,y].mina){
					if (contadorParaGanar == 0){
						cambiaMinas(x,y);
						this.tablero[x,y].mina = false;
						this.tablero[x,y].presionado = true;
						setEstado(Estado.JUGANDO);
						contadorParaGanar+=1;
						this.extender(x,y);
					} else{
						this.tablero[x,y].presionado = true;
						revelaMinas();
						setEstado(Estado.PERDIDO);
						stdout.printf("aaa\n");
					}
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

	/* Actualiza el número de minas al rededor de una celda.
	* @param x: coordenada en x.
	* @param y: coordenada en y.
	* @return número de minas al rededor de la celda (x,y).
	*/
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

	/* Extiende al presionar una casilla a todas las vecinas que no esten ya presionadas o con alguna mina o bandera
	 * @param x: coordenada en el eje x.
	 * @param y: coordenada en el eje y.
	 */
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
			if (i == 0) stdout.printf ("\t\t\t %i  ",i);
			else 
			if (i>9) stdout.printf (" %i ",i);
			else stdout.printf (" %i  ",i);
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

	/* Guarda un tablero.
	* @return true si se pudo guardar, false de lo contrario.
	*/
	public bool guardar() {
		Json.Builder builder = new Json.Builder ();
		builder.begin_object();

		string estado;
		if (this.estado == Estado.JUGANDO) estado = "jugando";
		else if (this.estado == Estado.PERDIDO) estado = "perdido";
		else estado = "ganado";
		builder.set_member_name("estado");
		builder.add_string_value(estado);

		builder.set_member_name("filas");
		builder.add_int_value(this.filas);
		builder.set_member_name("columnas");
		builder.add_int_value(this.columnas);
		builder.set_member_name("minas");
		builder.add_int_value(this.minas);
		builder.set_member_name("contador");
		builder.add_int_value(this.contadorParaGanar);

		builder.set_member_name("tablero");
		builder.begin_array();
		for (int i = 0; i < this.filas; i++) {
			builder.begin_array();
			for (int j = 0; j < this.columnas; j++) {
				Celda c = tablero[i,j];
				builder.begin_array();
				builder.add_int_value(c.minasAlrededor);
				builder.add_boolean_value(c.bandera);
				builder.add_boolean_value(c.mina);
				builder.add_boolean_value(c.presionado);
				builder.end_array();
			}
			builder.end_array();
		}
		builder.end_array();

		builder.end_object();
		Json.Generator generator = new Json.Generator();
		Json.Node root = builder.get_root();
		generator.set_root(root);
		string str = generator.to_data(null);

		try {
			var file = File.new_for_path("./.tablero.json");
			if (file.query_exists()) file.delete();
			var dos = new DataOutputStream(file.create(FileCreateFlags.REPLACE_DESTINATION));
			uint8[] data = str.data;
			long written = 0;
			while (written < data.length) { 
				written += dos.write(data[written:data.length]);
			}
		} catch (Error e) {
			stdout.printf("Error al escribir");
			return false;
		}
		return true;
	}

	/* Carga un tablero guardado.
	* @return true si se pudo cargar, false de lo contrario.
	*/
	public bool cargar() {
		var file = File.new_for_path("./.tablero.json");
		if (!file.query_exists ()) return false;
		string data = "";

		try {
			var dis = new DataInputStream(file.read());
			string line;
			while ((line = dis.read_line (null)) != null)
				data += line;
		} catch (Error e) {
			return false;
		}

		var parser = new Json.Parser();
		try{
			parser.load_from_data(data);
		} catch (GLib.Error e){}
		var root = parser.get_root().get_object();

		string estado = root.get_string_member("estado");
		if (estado == "jugando") this.estado = Estado.JUGANDO;
		else if (estado == "perdido") this.estado = Estado.PERDIDO;
		else this.estado = Estado.GANADO;
		this.filas = (int)root.get_int_member("filas");
		this.columnas = (int)root.get_int_member("columnas");
		this.minas = (int)root.get_int_member("minas");
		this.contadorParaGanar = (int)root.get_int_member("contador");

		this.tablero = new Celda[this.filas,this.columnas];
		var minas = root.get_array_member("tablero");
		for (int i = 0; i < filas; i++) {
			var fila = minas.get_array_element(i);
			for (int j = 0; j < columnas; j++) {
				var celda = fila.get_array_element(j);
				int alrededor = (int)celda.get_int_element(0);
				bool bandera = celda.get_boolean_element(1);
				bool minado = celda.get_boolean_element(2);
				bool presionado = celda.get_boolean_element(3);
				this.tablero[i,j] = new Celda(alrededor, minado, presionado,
					bandera);
			}
		}

		return true;
	}
}