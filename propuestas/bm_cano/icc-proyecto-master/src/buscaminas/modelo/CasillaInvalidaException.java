package buscaminas.modelo;

public class CasillaInvalidaException extends RuntimeException {
	public CasillaInvalidaException(String mensaje) {
		super(mensaje);
	}
}
