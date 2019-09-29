package buscaminas.modelo;

import java.io.Serializable;

/**
 * Casillas del tablero.
 * @author Alejandro Hernandez Cano
 */
public class Casilla implements Serializable {
	private boolean presionado;
	private boolean abanderado;
	private final boolean minado;

	public Casilla() {
		this(false);
	}

	public Casilla(boolean minado) {
		this.presionado = false;
		this.abanderado = false;
		this.minado = minado;
	}

	public void presionar() throws CasillaInvalidaException {
		if (this.presionado)
			throw new CasillaInvalidaException("Casilla ya presionada");
		if (this.abanderado)
			throw new CasillaInvalidaException("Casilla con bandera");

		this.presionado = true;
	}

	public void ponerBandera() throws CasillaInvalidaException {
		if (this.presionado)
			throw new CasillaInvalidaException("Casilla ya presionada");
		if (this.abanderado)
			throw new CasillaInvalidaException("Casilla ya abanderada");

		this.abanderado = true;
	}

	public boolean getPresionado() { return this.presionado; }
	public boolean getAbanderado() { return this.abanderado; }
	public boolean getMinado() { return this.minado; }

	@Override
	public String toString() {
		if (this.abanderado) return "[F]";
		if (!this.presionado) return "[?]";
		if (this.minado) return "[B]";
		return "[ ]";
	}
}
