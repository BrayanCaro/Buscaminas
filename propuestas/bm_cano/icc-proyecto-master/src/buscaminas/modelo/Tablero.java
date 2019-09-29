package buscaminas.modelo;

import java.io.Serializable;

/**
 * Tablero.
 * @author Alejandro Hernandez Cano
 */
public class Tablero implements Serializable {
	protected Casilla[][] casillas;
	protected int x;
	protected int y;

	public Tablero() {
		this(8, 8);
	}

	public Tablero(int x, int y) throws IllegalArgumentException {
		if (x < 1 || y < 1)
			throw new IllegalArgumentException("Tamano invalido");

		this.casillas = new Casilla[x][y];
		this.x = x;
		this.y = y;
		
		this.inicializarTablero();
	}

	private void inicializarTablero() {
		for (int i = 0; i < this.x; i++)
			for (int j = 0; j < this.y; j++)
				this.casillas[i][j] = new Casilla();
	}

	@Override
	public String toString() {
		String res = "";

		for (Casilla[] i : casillas) {
			for (Casilla casilla : i)
				res += casilla;
			res += "\n";
		}

		return res;
	}
}
