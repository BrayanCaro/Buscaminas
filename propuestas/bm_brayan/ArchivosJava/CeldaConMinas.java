/**
 * Clase para representar las celdas que tienen una mina
 * @author Brayan Martinez Santana
 * @version Primera version, Domingo 2 de Diciembre, 2018
 * @see Celdas
 */

public class CeldaConMinas extends Celdas {
private static final long serialVersionUID = 42l;
private boolean ganador;
private boolean explocion;

/**
 * Constructor de una celda con mina que no se puede ver ni esta marcada
 */
public CeldaConMinas(){
	ganador = false;
	vista = false;
	marca = false;
}

/**
 * Metodo para cambiar una bomba por una corona cuando el usuario gane
 */
public void ganar(){
	ganador = true;
}

/**
 * Metodo privado para explotar una mina
 */
public void explotar(){
	explocion = true;
}

/**
 * Metodo para convertir una celda con mina en una cadena de caracteres
 * @return String -- La celda en formato de cadena
 */
public String toString(){
	if (ganador) {
		return "🏆";
	} else {
		if (marca) {
			return "🚩";
		} else if (!vista) {
			return "❓";
		}
		else if (explocion) {
			return "💥";
		} else {
			return "💣";
		}
	}

}

} // Final de la clase CeldaConMina
