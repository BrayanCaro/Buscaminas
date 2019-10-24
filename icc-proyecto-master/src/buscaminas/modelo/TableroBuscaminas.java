package buscaminas.modelo;

import java.util.Random;

/**
 * Tablero de Buscaminas.  * @author Alejandro Hernandez Cano
 */
public class TableroBuscaminas extends Tablero {
	private boolean perdido;
	private boolean ganado;
	private final String nombre;
	private int minas;
	
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
		this.minas = m;
		
		this.inicializarCasillas(m);
	}

	private void inicializarCasillas(int m) {
		boolean[][] campoMinado = this.getMinas(m);

		for (int i = 0; i < super.x; i++)
			for (int j = 0; j < super.y; j++) {
				boolean minado = campoMinado[i][j];
				int minas = getMinasVecinas(campoMinado, i, j);
				super.casillas[i][j] = new Casilla(minado, minas);
			}
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

	private int getMinasVecinas(boolean[][] minado, int x, int y) {
		int minas = 0;
		int[][] coords = this.getCoords(x, y);

		for (int[] coord : coords)
			try {
				if (minado[coord[0]][coord[1]])
					minas++;
			} catch (ArrayIndexOutOfBoundsException ex) {
				continue;
			}

		return minas;
	}

	public void presionarCasilla(int x, int y) throws CasillaInvalidaException,
		                                              MovimientoInvalidoException {
		
		if (x < 0 || x >= super.x || y < 0 || y >= super.y)
			throw new CasillaInvalidaException("Coordenadas invalidas");
		if (this.perdido || this.ganado)
			throw new MovimientoInvalidoException("Partida ya finalizada");

		try {
			super.casillas[x][y].presionar();
			this.extender(x, y);
		} catch (CasillaInvalidaException ex) {
			throw ex;
		}

		this.update();
	}

	public void quitarBandera(int x, int y) throws CasillaInvalidaException,
	                                              MovimientoInvalidoException {
		
		if (x < 0 || x >= super.x || y < 0 || y >= super.y)
			throw new CasillaInvalidaException("Coordenadas invalidas");
		if (this.perdido || this.ganado)
			throw new MovimientoInvalidoException("Partida ya finalizada");
		if (!casillas[x][y].getAbanderado())
			throw new CasillaInvalidaException("Casilla sin bandera");

		try {
			super.casillas[x][y].quitarBandera();
		} catch (CasillaInvalidaException ex) {
			throw ex;
		}
	}

	public void ponerBandera(int x, int y) throws CasillaInvalidaException,
	                                              MovimientoInvalidoException {
		
		if (x < 0 || x >= super.x || y < 0 || y >= super.y)
			throw new CasillaInvalidaException("Coordenadas invalidas");
		if (this.perdido || this.ganado)
			throw new MovimientoInvalidoException("Partida ya finalizada");
		if (casillas[x][y].getPresionado())
			throw new CasillaInvalidaException("Casilla ya presionada");

		try {
			super.casillas[x][y].ponerBandera();
		} catch (CasillaInvalidaException ex) {
			throw ex;
		}

		this.update();
	}

	private void extender(int x, int y) {
		if (super.casillas[x][y].getVecinos() > 0)
			return;

		int[][] coords = { {x, y+1}, {x-1, y}, {x+1, y}, {x, y-1} };
		for (int[] coord : coords)
			try {
				Casilla c = super.casillas[coord[0]][coord[1]];
				if (!c.getMinado() && !c.getAbanderado() && !c.getPresionado()) {
					c.presionar();
					extender(coord[0], coord[1]);
				}
			} catch (ArrayIndexOutOfBoundsException ex) {
				continue;
			}
	}

	private void update() {
		System.out.println("A");
		boolean perdido = false;
		boolean ganado = true;

		for (int i = 0; i < this.x; i++)
			for (int j = 0; j < this.y; j++) {
				Casilla c = super.casillas[i][j];
				if (c.getMinado() && c.getPresionado()) {
					System.out.println("B");
					perdido = true;
					this.revelarTodo();
				}
				if (c.getMinado() && !c.getAbanderado()) {
					System.out.println("C");
					ganado = false;
				}
			}

		if (ganado) this.ganado = true;
		else this.ganado = false;

		if (perdido) this.perdido = true;
		else this.perdido = false;
	}

	private int[][] getCoords(int x, int y) {
		return new int[][]{
			{x-1, y+1}, {x, y+1}, {x+1, y+1},
			{x-1, y},             {x+1, y},
			{x-1, y-1}, {x, y-1}, {x+1, y-1}
		};
	}

	private void revelarTodo() {
		for (int i = 0; i < this.x; i++)
			for (int j = 0; j < this.y; j++)
				try { super.casillas[i][j].presionar(); } catch (Exception ex) {}
	}

	@Override
	public String toStringShort() {
		return "Usuario: " + this.nombre + ", Tamano: " + super.x + "x" +
		       super.y + ". Minas: " + this.minas + ".";
	}

	public boolean getPerdido() { return this.perdido; }
	public boolean getGanado() { return this.ganado; }
	public String getNombre() { return this.nombre; }
	public int getMinas() { return this.minas; }
	public int getX() { return this.x; }
	public int getY() { return this.y; }
}
