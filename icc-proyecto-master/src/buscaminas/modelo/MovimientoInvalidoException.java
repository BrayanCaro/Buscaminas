package buscaminas.modelo;

public class MovimientoInvalidoException extends RuntimeException {
	public MovimientoInvalidoException(String mensaje) {
		super(mensaje);
	}
}
