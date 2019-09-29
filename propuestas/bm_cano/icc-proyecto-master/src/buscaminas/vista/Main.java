package buscaminas.vista;

import buscaminas.modelo.TableroBuscaminas;
import buscaminas.modelo.CasillaInvalidaException;
import buscaminas.modelo.MovimientoInvalidoException;

/**
 * Buscaminas.
 * @author Alejandro Hernandez Cano
*/
public class Main {
	private static final MenuBuscaminas menu = new MenuBuscaminas();
	private static TableroBuscaminas tablero;

	private static void inicializarTablero() {
		String n; //nombre del usuario
		int x; //num de col
		int y; //num de fil
		int m; //num de minas		

		//solicita nombre
		menu.setTitulo("Iniciar nueva partida");
		menu.setDes("Iniciar una nueva partida de buscaminas");
		menu.setIns("Proporcionar nombre del usuario");
		n = menu.input("nombre");

		//solicita columnas
		menu.setDes(menu.getDes() + "\n\nDatos recabados:\n" +
					"Nombre: " + n);
		menu.setIns("Proporcionar numero de columnas");
		x = menu.inputInt("columnas", 8, 64);

		//solicita filas
		menu.setDes(menu.getDes() + "\nColumnas: " + x);
		menu.setIns("Proporcionar numero de filas");
		y = menu.inputInt("filas", 8, 64);

		//solicita minas
		menu.setDes(menu.getDes() + "\nFilas: " + y);
		menu.setIns("Proporcionar numero de minas");
		m = menu.inputInt("minas", 8, x*y);

		tablero = new TableroBuscaminas(x, y, m, n);

		//muestra info
		menu.setTitulo("Datos");
		menu.setDes("Datos recabados:\n\nNombre: " + n +
					"\nColumnas: " + x + "\nFilas: " + y +
					"\nMinas: " + m);

		menu.impTitulo();
		menu.impDes();
		menu.enterParaContinuar();
	}

	private static void jugar() {
	}

	public static void main(String[] args) {
		try {
			
			boolean exit;
			do {
				int opc;
				exit = false;

				menu.cargarPrincipal();
				opc = menu.inputIntOpc("opc");


				// Iniciar partida
				if (opc == 0) {
					inicializarTablero();
					jugar();
				}

				// Cargar partida
				else if (opc == 1);

				// Salir
				else if (opc == 2)
					exit = true;
				
			} while (!exit);

		} catch (Throwable ex) {
			System.out.println("Error fatal al realizar la accion anterior. Los datos " +
							   "de error son: " + ex.getMessage());
			System.out.println("Reestablecer programa en la situacion actual podria ser " +
							   "inestable. Favor de proporcionarle los datos del error " +
							   "mostrados anteriormente al provedor del software.");
			System.out.println("Terminando ejecucion...");
			System.exit(1);
		}
	}
}
