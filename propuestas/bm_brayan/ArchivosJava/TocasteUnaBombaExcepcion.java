/**
 * Excepcion para el manejo de bombas en una celda
 * @author Brayan Martinez Santana
 * @version Primera version, Lunes 3 de Diciembre, 2018
 */

public class TocasteUnaBombaExcepcion extends Exception {
private static final long serialVersionUID = 42l;

/**
 * Metodo para crear una exception del tipo TocasteUnaBomba
 * @param mensaje Refiere al mensaje que quiere presentar
 */
public TocasteUnaBombaExcepcion(String mensaje){
	super(mensaje);
}

}
