/**
 * Clase para representar una celda del tablero
 * @author Brayan Martinez Santana
 * @version Primera version, Lunes 10 de Diciembre, 2018
 */

import java.io.Serializable;

public class Celdas implements Serializable {

private static final long serialVersionUID = 42l;
protected boolean vista;
protected boolean marca;

/**
 * Constructor de una celda que no se puede ser vista y no se puede marcar
 */
public Celdas(){
	vista = false;
	marca = false;
}

/**
 * Metodo para convertir una celda a una pequeña cadena de caracteres
 * @return La celda en formato de cadena
 */
public String toString(){
	if (marca) {
		return "🚩";
	} else if (!vista) {
		return "❓";
	}
	else {
		return "";
	}
}

/**
 * Metodo para ver una celda
 */
public void ver(){
	vista = true;
}

/**
 * Metodo para marcar una celda
 */
public void marcar(){
	marca = !marca;
}

/**
 * Metodo para saber si una comba ha sido vista
 * @return Regresa true si la celda ha sido vista, false si no
 */
public boolean haSidoVista(){
	return vista;
}


/**
 * Metodo para saber si una comba ha sido marcada
 * @return Regresa true si la celda ha sido marcada, false si no
 */
public boolean haSidoMarcada(){
	return marca;
}

}
