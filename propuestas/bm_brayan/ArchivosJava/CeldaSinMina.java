/**
 * Clase para representar las celdas de un tablero.
 * Objetivo. Servir como base para la clase tablero
 * @author Brayan Martinez Santana
 * @version Primera version, Domingo 2 de Diciembre, 2018
 */

import java.io.Serializable;

public class CeldaSinMina extends Celdas implements Serializable {
private static final long serialVersionUID = 42l;
private int marcador;

/**
 * Metodo para cambiar el estado de una celda (aumentar el numero de bombas aledañas a la celda en 1)
 */
public void aumentar(){
	marcador += 1;
}

/**
 * Metodo para ver cuantas minas tiene una celda a su alrededor
 * @return La cantidad de bombas que hay alrededor de una celda
 */
public int obtenerMarcador(){
	return marcador;
}

/**
 * Metodo para convertir una celda sin mina a una pequeña cadena de caracteres
 * @return La celda en formato de cadena
 */
public String toString(){
	if (this.haSidoVista()) {
		if (marcador == 0) {
			return "  ";
		} else {
			return " " + String.valueOf(marcador);
		}
	} else {
		return super.toString();
	}
}
} // Final de la clase
