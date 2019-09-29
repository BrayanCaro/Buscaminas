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
	}

	public String toStringShort() {
		return "Tablero de " + this.x + "x" + this.y + ".";
	}

	@Override
	public String toString() {
		String[] filas = new String[y];
		String res = "	";

		for (int i = 0; i < this.x; i++)
			if (i < 10)
				res += i + ". ";
			else
				res += i + ".";
		res += "\n";

		for (int i = 0; i < this.y; i++)
			filas[i] = i + ".	";

		for (int i = 0; i < this.y; i++) {
			for (int j = 0; j < this.x; j++)
				filas[i] += this.casillas[j][i];
			filas[i] += "\n";
		}

		for (int i = 0; i < this.y; i++)
			res += filas[i];

		return res;
	}
}
