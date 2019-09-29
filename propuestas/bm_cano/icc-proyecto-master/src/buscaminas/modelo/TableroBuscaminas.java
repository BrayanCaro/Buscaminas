package buscaminas.modelo;

import java.util.Random;

/**
 * Tablero de Buscaminas.
 * @author Alejandro Hernandez Cano
 */
public class TableroBuscaminas extends Tablero {
	private boolean perdido;
	private boolean ganado;
	private final String nombre;
	
	public TableroBuscaminas() {
		this(8, 8);
	}
	
	public TableroBuscaminas(int x, int y) {
		this(x, y, 8);
	}

	public TableroBuscaminas(int x, int y, int m) {
		this(x, y, m, "");
	}

	public TableroBuscaminas(int x, int y, int m, String n) throws IllegalArgumentException {
		if (x < 8 || 64 < x || y < 8 || 64 < y)
			throw new IllegalArgumentException("Tamano invalido");
		if (m < 8 || x*y < m)
			throw new IllegalArgumentException("Numero de minas invalido");

		super.casillas = new Casilla[x][y];
		super.x = x;
		super.y = y;

		this.perdido = false;
		this.ganado = false;
		this.nombre = n;
		
		this.inicializarCasillas(m);
	}

	private void inicializarCasillas(int m) {
		boolean[][] campoMinado = this.getMinas(m);

		for (int i = 0; i < super.x; i++)
			for (int j = 0; j < super.y; j++)
				if (campoMinado[i][j])
					super.casillas[i][j] = new Casilla(true);
				else
					super.casillas[i][j] = new Casilla(false);

	}

	private boolean[][] getMinas(int m) {
		Random rand = new Random();
		boolean[][] campo = new boolean[super.x][super.y];

		for (int i = 0; i < m; i++) {
			int a = rand.nextInt(super.x);
			int b = rand.nextInt(super.y);

			if (campo[a][b])
				i--;
			else
				campo[a][b] = true;
		}

		return campo;
	}

	public void presionarCasilla(int x, int y) throws CasillaInvalidaException,
													  MovimientoInvalidoException {
		
		if (x < 0 || x >= super.x || y < 0 || y >= super.y)
			throw new CasillaInvalidaException("Coordenadas invalidas");
		if (this.perdido)
			throw new MovimientoInvalidoException("Partida ya perdida");

		try {
			super.casillas[x][y].presionar();
		} catch (CasillaInvalidaException ex) {
			throw ex;
		}

		if (casillas[x][y].getMinado())
			this.perdido = true;
	}

	public void ponerBandera(int x, int y) throws CasillaInvalidaException,
												  MovimientoInvalidoException {
		
		if (x < 0 || x >= super.x || y < 0 || y >= super.y)
			throw new CasillaInvalidaException("Coordenadas invalidas");
		if (this.perdido)
			throw new MovimientoInvalidoException("Partida ya perdida");

		try {
			super.casillas[x][y].ponerBandera();
		} catch (CasillaInvalidaException ex) {
			throw ex;
		}
	}

	public boolean getPerdido() { return this.perdido; }
	public boolean getGanado() { return this.ganado; }
	public String getNombre() { return this.nombre; }
}
