package buscaminas.vista;

import buscaminas.modelo.Tablero;
import buscaminas.modelo.TableroBuscaminas;
import buscaminas.modelo.CasillaInvalidaException;
import buscaminas.modelo.MovimientoInvalidoException;
import buscaminas.util.TableroBuscaminasIO;

import java.io.IOException;
import java.io.File;

/**
 * Buscaminas.
 * @author Alejandro Hernandez Cano
*/
public class Main {
	private static final MenuBuscaminas MENU;
	private static TableroBuscaminas tablero;

	private static final String PATH;
	private static final TableroBuscaminasIO IO;

	static {
		MENU = new MenuBuscaminas();
		PATH = PATH();
		IO = new TableroBuscaminasIO(PATH + "/data/tableros");
	}

	private static String PATH() {
		try {
			return new File(Main.class.getProtectionDomain().getCodeSource().getLocation().toURI()).getParent();
		} catch (Exception ex) {
			return "";
		}
	}


	private static void inicializarTablero() {
		String n; //nombre del usuario
		int x; //num de col
		int y; //num de fil
		int m; //num de minas

		//solicita nombre
		MENU.setTitulo("Iniciar nueva partida");
		MENU.setDes("Iniciar una nueva partida de buscaminas");
		MENU.setIns("Proporcionar nombre del usuario");
		n = MENU.input("nombre");

		//solicita columnas
		MENU.setDes(MENU.getDes() + "\n\nDatos recabados:\n" +
					"Nombre: " + n);
		MENU.setIns("Proporcionar numero de columnas");
		x = MENU.inputInt("columnas", 8, 64);

		//solicita filas
		MENU.setDes(MENU.getDes() + "\nColumnas: " + x);
		MENU.setIns("Proporcionar numero de filas");
		y = MENU.inputInt("filas", 8, 64);

		//solicita minas
		MENU.setDes(MENU.getDes() + "\nFilas: " + y);
		MENU.setIns("Proporcionar numero de minas");
		m = MENU.inputInt("minas", 8, x*y);

		tablero = new TableroBuscaminas(x, y, m, n);

		//muestra info
		MENU.setTitulo("Datos");
		MENU.setDes("Datos recabados:\n\nNombre: " + n +
					"\nColumnas: " + x + "\nFilas: " + y +
					"\nMinas: " + m);

		MENU.impTitulo();
		MENU.impDes();
		MENU.enterParaContinuar();
	}

	private static void jugar() {
		MENU.setTitulo("Juego en curso");
		do {
			MENU.setDes(tablero.toString());
			MENU.setIns("Proporcionar instruccion:\n" +
			            "g o guardar = guardar partida\n" +
			            "c o continuar = continuar juego");

			String s = MENU.inputStringSelect("ins", "g", "guardar", "c", "continuar");

			if (s.equals("g") || s.equals("guardar")) {
				guardar();
				MENU.impAviso("Partida guardada exitosamente");
				return;
			} else if (s.equals("c") || s.equals("continuar"))
				mover();
		} while(!tablero.getPerdido() && !tablero.getGanado());

		if (tablero.getGanado())
			MENU.setTitulo("GANASTE");
		else
			MENU.setTitulo("PERDISTE");
		MENU.setDes(tablero.toString());

		MENU.impTitulo();
		MENU.impDes();
		MENU.enterParaContinuar();
	}

	private static void mover() {
		MENU.setDes(tablero.toString());
		MENU.setIns("Proporcionar coordenadas:");
		int x = MENU.inputInt("x", 0, tablero.getX()-1);
		int y = MENU.inputInt("y", 0, tablero.getY()-1);

		MENU.setIns("Proporcionar instruccion:\n" + 
		            "p o presionar = presionar\n" +
		            "b o bandera = poner bandera\n" +
		            "q o quitar = quitar bandera");

		String s = MENU.inputStringSelect("ins", "p", "presionar", 
		                                  "b", "bandera", "q", "quitar");

		try {
			if (s.equals("p") || s.equals("presionar"))
				tablero.presionarCasilla(x, y);
			else if (s.equals("b") || s.equals("bandera"))
				tablero.ponerBandera(x, y);
			else if (s.equals("q") || s.equals("quitar"))
				tablero.quitarBandera(x, y);
		} catch (CasillaInvalidaException ex) {
			MENU.impError(ex);
		} catch (MovimientoInvalidoException ex) {
			MENU.impError(ex);
		}
	}

	private static void guardar() {
		try {
			IO.guardar(tablero);
		} catch (IOException ex) {
			MENU.impError(ex);
		}
	}

	private static void cargarTablero() {
		TableroBuscaminas[] t = IO.getOpciones();
		String[] s = new String[t.length];
		for (int i = 0; i < t.length; i++)
			s[i] = t[i].toStringShort();

		if (t.length == 0) {
			MENU.impError("Aun no se tienen tableros guardados");
			return;
		}

		MENU.setTitulo("Cargar nueva partida");
		MENU.setDes("Cargar una partida existente de buscaminas");
		MENU.setIns("Proporcionar la partida deseada");
		MENU.setOpciones(s);

		tablero = t[MENU.inputIntOpc("opc")];

		String n = tablero.getNombre();
		int x = tablero.getX();
		int y = tablero.getY();
		int m = tablero.getMinas();

		//muestra info
		MENU.setTitulo("Datos");
		MENU.setDes("Datos del tablero:\n\nNombre: " + n +
					"\nColumnas: " + x + "\nFilas: " + y +
					"\nMinas: " + m);

		MENU.impTitulo();
		MENU.impDes();
		MENU.enterParaContinuar();

		jugar();
	}

	private static Tablero cargar(int i) {
		try {
			return IO.cargar(i);
		} catch (IOException|ClassNotFoundException ex) {
			MENU.impError(ex);
			return null;
		}
	}

	public static void main(String[] args) {
		try {
			boolean exit;
			do {
				int opc;
				exit = false;

				MENU.cargarPrincipal();
				opc = MENU.inputIntOpc("opc");


				// Iniciar partida
				if (opc == 0) {
					inicializarTablero();
					jugar();

				// Cargar partida
				} else if (opc == 1) {
					cargarTablero();

				// Salir
				} else if (opc == 2)
					exit = true;
				
			} while (!exit);

			MENU.impDespedida();

		} catch (Throwable ex) {
			String msg = ex + "\n";
			for (StackTraceElement stack : ex.getStackTrace())
				msg += stack.toString() + "\n";

			System.out.println("Error fatal al realizar la accion anterior. Los datos " +
			                   "de error son: ");
			System.out.println();
			System.out.println(msg);
			System.out.println();
			System.out.println("Reestablecer programa en la situacion actual podria ser " +
			                   "inestable. Favor de proporcionarle los datos del error " +
			                   "mostrados anteriormente al provedor del software.");
			System.out.println("Terminando ejecucion...");
			System.exit(1);
		}
	}
}
