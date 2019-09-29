/**
 * Clase para representar tableros que ya estan representados.
 * Objetivo. Ser una opcion para quienes quieran personalizar un juego.
 * @author Brayan Martinez Santana
 * @version Primera version, Domingo 2 de Diciembre, 2018
 * @see Tablero
 */

import java.io.*;

public class TableroPersonalizado extends Tablero {
private static final long serialVersionUID = 42l;

/**
 * Constructor de un tablero con celdas a partir de un numero de bombas a poner
 * @param filas - Indica la cantidad de filas del tablero
 * @param columnas - Indica la cantidad de columnas del tablero
 * @param numeroDeBombasParaPoner - Indica la cantidad de bombas que tendra el tablero
 */
public TableroPersonalizado(int filas, int columnas, int numeroDeBombasParaPoner) throws IllegalArgumentException {
	if (numeroDeBombasParaPoner >= filas*columnas)
		throw new IllegalArgumentException ("Necesitas poner menos bombas");

	celdas = new Celdas[filas][columnas];

	for (int i = 0; i<celdas.length; i++ ) {
		for (int j=0; j<celdas[0].length; j++ ) {
			celdas[i][j]= new CeldaSinMina();
		}
	}

	for (int i = 0; i < numeroDeBombasParaPoner; i++) {
		int numeroAleratorioFilas = super.numeroEnteroAleatorio(this.celdas.length-1);
		int numeroAleratorioColumnas = super.numeroEnteroAleatorio(this.celdas[0].length-1);

		if (!(celdas[ numeroAleratorioFilas ][ numeroAleratorioColumnas ] instanceof CeldaConMinas)) {
			celdas[ numeroAleratorioFilas ][ numeroAleratorioColumnas ] = new CeldaConMinas();
			asignarNumeroDeBombasAledañas(numeroAleratorioFilas,numeroAleratorioColumnas);
		} else {
			if (i <= (celdas.length+1)*(celdas[0].length+1)) //si se repite las cordenadas, lo hace de nuez
				i--;
		}
	}

} // Fin del metodo Constructor

/**
 * Metodo para revelar una o mas casillas segun sea el caso
 * @param cordenadaX -- Hace referencia a la posicion que queremos revelar en el eje x
 * @param cordenadaY -- Hace referencia a la posicion que queremos revelar en el eje y
 * @throws IndexOutOfBoundsException Si se intenta acceder a una celda del tablero que no existe
 * @throws IllegalAccessException Si se quiere ver una celda que ya ha sido vista o que esta marcada
 * @throws TocasteUnaBombaExcepcion Si el usuario toco una bomba
 * @throws Exception Si occure un error en general
 */
public void elegirCelda(int cordenadaX, int cordenadaY) throws Exception,IndexOutOfBoundsException, IllegalAccessException,TocasteUnaBombaExcepcion {
	if (cordenadaX < 0 || cordenadaY < 0)
		throw new IndexOutOfBoundsException("El tablero no puede tener cordenadas negativas");

	if (cordenadaX >= celdas.length || cordenadaY >= celdas[0].length)
		throw new IndexOutOfBoundsException("El tablero no puede tener cordenadas tan grandes");

	if (celdas[cordenadaX][cordenadaY].haSidoVista())
		throw new IllegalAccessException("Esta celda ya es visible");

	if (celdas[cordenadaX][cordenadaY].haSidoMarcada())
		throw new IllegalAccessException("No puedes ver una mina si ya la marcaste, para hacer eso vuelve a marcar la celda");

	celdas[cordenadaX][cordenadaY].ver();

	if (!(celdas[cordenadaX][cordenadaY] instanceof CeldaConMinas)) {
		if (((CeldaSinMina)celdas[cordenadaX][cordenadaY]).obtenerMarcador() == 0)
			buscarTodosLosCerosEncerrados(this.celdas,cordenadaX,cordenadaY);
	}
	else {
		((CeldaConMinas)celdas[cordenadaX][cordenadaY]).explotar();
		throw new TocasteUnaBombaExcepcion("Perdiste :(");
	}
}

/**
 * Metodo para mostrar todas las bombas si un jugador pierde
 */
public void mostrarTodasLasBombas(){
	for (int i = 0; i<celdas.length; i++ ) {
		for (int j = 0; j<celdas[0].length; j++ ) {
			if ( celdas[i][j] instanceof CeldaConMinas )
				celdas[i][j].ver();
		}
	}
} // Fin del metodo mostrarTodasLasBombas

/*
 * Metodo para calcular todos las casillas que tengan un 0
 * @param x Hace referencia a la posicion que queremos mover en el eje x
 * @param y Hace referencia a la posicion que necesito mover en el eje y
 */
private static void buscarTodosLosCerosEncerrados(Celdas[][] celdas, int x, int y){
	// El metodo obtenerMarcador dice solo el numero de la celda (0,1,2,3,4,5,6,7 o 8)
	// El metodo ver es modificador y solo hace que la celda se pueda ver
	celdas[x][y].ver();
	int filas = celdas.length-1;
	int columnas = celdas[0].length-1;
	boolean xEsValidoArriba = (x+1) < celdas.length;
	boolean xEsValidoAbajo = (x-1) >= 0;
	boolean yEsValidoIzquierda = 0 <= (y-1);
	boolean yEsValidoDerecha = (y+1) < celdas[0].length;
	boolean xyEsValidoArribaIzquierda = xEsValidoArriba && yEsValidoIzquierda;
	boolean xyEsValidoArribaDerecha = xEsValidoArriba && yEsValidoDerecha;
	boolean xyEsValidoAbajoIzquierda = xEsValidoAbajo && yEsValidoIzquierda;
	boolean xyEsValidoAbajoDerecha = xEsValidoAbajo && yEsValidoDerecha;
	// Validacion 1 ↓
	if (xEsValidoArriba && !celdas[x+1][y].haSidoVista()) {
		if (((CeldaSinMina)celdas[x+1][y]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x+1,y);
		if (((CeldaSinMina)celdas[x+1][y]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x+1][y].ver();
	}
	// Validacion 2 ↓
	if (xEsValidoAbajo && !celdas[x-1][y].haSidoVista()) {
		if (((CeldaSinMina)celdas[x-1][y]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x-1,y);
		if (((CeldaSinMina)celdas[x-1][y]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x-1][y].ver();
	}
	// Validacion 3 ↓
	if (yEsValidoIzquierda && !celdas[x][y-1].haSidoVista()) {
		if (((CeldaSinMina)celdas[x][y-1]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x,y-1);
		if (((CeldaSinMina)celdas[x][y-1]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x][y-1].ver();
	}
	// Validacion 4 ↓
	if (yEsValidoDerecha && !celdas[x][y+1].haSidoVista()) {
		if (((CeldaSinMina)celdas[x][y+1]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x,y+1);
		if (((CeldaSinMina)celdas[x][y+1]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x][y+1].ver();
	}
	// Validacion 5 ↓
	if (xyEsValidoArribaIzquierda && !celdas[x+1][y-1].haSidoVista()) {
		if (((CeldaSinMina)celdas[x+1][y-1]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x+1,y-1);
		if (((CeldaSinMina)celdas[x+1][y-1]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x+1][y-1].ver();
	}
	// Validacion 6 ↓
	if (xyEsValidoArribaDerecha && !celdas[x+1][y+1].haSidoVista()) {
		if (((CeldaSinMina)celdas[x+1][y+1]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x+1,y+1);
		if (((CeldaSinMina)celdas[x+1][y+1]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x+1][y+1].ver();
	}
	// Validacion 7 ↓
	if (xyEsValidoAbajoIzquierda && !celdas[x-1][y-1].haSidoVista()) {
		if (((CeldaSinMina)celdas[x-1][y-1]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x-1,y-1);
		if (((CeldaSinMina)celdas[x-1][y-1]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x-1][y-1].ver();
	}
	// Validacion 8 ↓
	if (xyEsValidoAbajoDerecha && !celdas[x-1][y+1].haSidoVista()) {
		if (((CeldaSinMina)celdas[x-1][y+1]).obtenerMarcador() == 0) // Si encuentra un 0 hace recurción
			buscarTodosLosCerosEncerrados(celdas,x-1,y+1);
		if (((CeldaSinMina)celdas[x-1][y+1]).obtenerMarcador() != 0) // Si encuentra una celda que tiene un numero distinto de 0, solo lo muestra
			celdas[x-1][y+1].ver();
	}
}

/*
 * Metodo para calcular y asignar la candiad de bombas aledañas a una celda
 * @param cordenadaX -- Hace referencia a la posicion que queremos mover en el eje x
 * @param cordenadaY -- Hace referencia a la posicion que necesito mover en el eje y
 */
private void asignarNumeroDeBombasAledañas(int cordenadaX, int cordenadaY){
	int filas = celdas.length-1;
	int columnas = celdas[0].length-1;
	boolean xEsValidoArriba = (cordenadaX+1) < celdas.length;
	boolean xEsValidoAbajo = (cordenadaX-1) >= 0;
	boolean yEsValidoIzquierda = 0 <= (cordenadaY-1);
	boolean yEsValidoDerecha = (cordenadaY+1) < celdas[0].length;
	boolean xyEsValidoArribaIzquierda = xEsValidoArriba && yEsValidoIzquierda;
	boolean xyEsValidoArribaDerecha = xEsValidoArriba && yEsValidoDerecha;
	boolean xyEsValidoAbajoIzquierda = xEsValidoAbajo && yEsValidoIzquierda;
	boolean xyEsValidoAbajoDerecha = xEsValidoAbajo && yEsValidoDerecha;

	if (xEsValidoArriba && !(celdas[cordenadaX+1][cordenadaY] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX+1][cordenadaY]).aumentar();
	}
	if (xEsValidoAbajo && !(celdas[cordenadaX-1][cordenadaY] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX-1][cordenadaY]).aumentar();
	}
	if (yEsValidoIzquierda && !(celdas[cordenadaX][cordenadaY-1] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX][cordenadaY-1]).aumentar();
	}
	if (yEsValidoDerecha && !(celdas[cordenadaX][cordenadaY+1] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX][cordenadaY+1]).aumentar();
	}
	if (xyEsValidoArribaIzquierda && !(celdas[cordenadaX+1][cordenadaY-1] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX+1][cordenadaY-1]).aumentar();
	}
	if (xyEsValidoArribaDerecha && !(celdas[cordenadaX+1][cordenadaY+1] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX+1][cordenadaY+1]).aumentar();
	}
	if (xyEsValidoAbajoIzquierda && !(celdas[cordenadaX-1][cordenadaY-1] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX-1][cordenadaY-1]).aumentar();
	}
	if (xyEsValidoAbajoDerecha && !(celdas[cordenadaX-1][cordenadaY+1] instanceof CeldaConMinas)) {
		((CeldaSinMina)celdas[cordenadaX-1][cordenadaY+1]).aumentar();
	}
}

/**
 * Metodo para marcar una celda durante el juego
 * @param cordenadaX -- Hace referencia a la posicion que queremos mover en el eje x
 * @param cordenadaY -- Hace referencia a la posicion que necesito mover en el eje y
 * @throws IndexOutOfBoundsException Si se intenta acceder a una celda del tablero que no existe
 * @throws IllegalAccessException Si se quiere marcar una celda que esta esta visible
 */
public void marcarCelda(int cordenadaX, int cordenadaY) throws IndexOutOfBoundsException, IllegalAccessException {
	if (cordenadaX < 0 || cordenadaY < 0)
		throw new IndexOutOfBoundsException("El tablero no puede tener cordenadas negativas");

	if (cordenadaX >= celdas.length || cordenadaY >= celdas[0].length)
		throw new IndexOutOfBoundsException("El tablero no puede tener cordenadas tan grandes");

	if (celdas[cordenadaX][cordenadaY].haSidoVista())
		throw new IllegalAccessException("No puedes marcar una celda que ya es visible");

	celdas[cordenadaX][cordenadaY].marcar();
}

/**
 * Metodo para guardar una partida
 * @param nombreDelArchivo -- Refiere al nombre del archivo que centendra la partida
 * @throws FileNotFoundException -- Si el archio no es encontrado
 * @throws RuntimeException -- Si el archivo no puede ser leido, o si el archivo no puede ser escrito
 */
public void guardarPartidaEnUnArchivo(String nombreDelArchivo) throws IOException {
	ObjectOutputStream celdasParaGrabar = new ObjectOutputStream( new FileOutputStream(nombreDelArchivo));
	celdasParaGrabar.writeObject(this.celdas);
	celdasParaGrabar.close();
}

/**
 * Metodo para cargar una partida de un archivo
 * @param nombreDelArchivo -- Refiere al nombre del archivo que contiene las partidas
 * @return Celdas[][] --  Es un arreglo bidimensial de celdas
 * @throws Exception Si ocurre un error con el acceso a los archivos
 */
public Celdas[][] cargarPartidaDeUnArchivo(String nombreDelArchivo) throws Exception {
	ObjectInputStream celdasParaCargar = new ObjectInputStream( new FileInputStream (nombreDelArchivo));
	this.celdas = (Celdas[][]) celdasParaCargar.readObject();
	return this.celdas;
}

/**
 * Metodo para generar las dimensiones de un tablero
 * @return String -- Refiere a la dimension en el formato "n x m"
 */
public String dimension(){
	return celdas.length + "×" + celdas[0].length;
}

/**
 * Metodo que evalua el tablero y determina si el jugador ya hago
 * @return boolean -- Regresa falso y el jugador no ha ganado, true si el jugador ya gano
 */
public boolean elJugadorYaGano(){
	return true;
}

/**
 * Metodo que dice cuantas celdas hay sin ver (es utilizado para determinar si un jugador gana anque no marca nada)
 * @return int -- Dice la cantidad de casillas que faltan por descubrir
 */
public int jugadorGanoSinMarcas(){
	int a = 0;

	for (int i = 0; i<celdas.length; i++ ) {
		for (int j = 0; j<celdas[0].length; j++ ) {
			if (!celdas[i][j].haSidoVista())
				a++;
		}
	}
	return a;
}

/**
 * Metodo que modifica el mapa para cuando el usuario gana
 */
public void ganador(){
	for (int i = 0; i<celdas.length; i++ ) {
		for (int j = 0; j<celdas[0].length; j++ ) {
			if (celdas[i][j] instanceof CeldaConMinas)
				((CeldaConMinas)celdas[i][j]).ganar();
		}
	}
}

/**
 * Metodo auxilar para centrar textos
 * @return String -- Los espacios en blanco centrados
 */
public String centrar(){
	int largo = (celdas.length*5-35)/2;
	String salida = "";
	for (int i =0; i< largo; i++ ) {
		salida += " ";
	}
	return (salida);
}
}
