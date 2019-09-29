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
	private final int vecinos;

	public Casilla(int vecinos) {
		this(false, vecinos);
	}

	public Casilla(boolean minado, int vecinos) {
		this.presionado = false;
		this.abanderado = false;
		this.minado = minado;
		this.vecinos = vecinos;
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

	public void quitarBandera() throws CasillaInvalidaException {
		if (!this.abanderado)
			throw new CasillaInvalidaException("Casilla sin bandera");

		this.abanderado = false;
	}

	public boolean getPresionado() { return this.presionado; }
	public boolean getAbanderado() { return this.abanderado; }
	public boolean getMinado() { return this.minado; }
	public int getVecinos() { return this.vecinos; }

	@Override
	public String toString() {
		if (this.abanderado) return "[F]";
		if (!this.presionado) return "[?]";
		if (this.minado) return "[B]";
		if (this.vecinos > 0) return "[" + vecinos + "]";
		return "[ ]";
	}
}
