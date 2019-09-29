package buscaminas.vista;

import java.util.Scanner;
import java.util.NoSuchElementException;

/**
 * Clase que representa un menu.
 * @author Alejandro Hernandez Cano
 */
public class Menu {
	protected Scanner scanner = new Scanner(System.in);
	protected String titulo;
	protected String descripcion;
	protected String instruccion;
	protected String[] opciones;

	// -- Constructores -- \\

	/**
	 * Menu vacio.
	 */
	public Menu () {
		this("", "", "");
	}

	/**
	 * Menu con titulo, descripcion e instruccion especificado.
	 * Las tres cadenas seran guardadas y utilizadas mas tarde para representar
	 * el Menu
	 * @param t titulo
	 * @param d descripcion
	 * @param i instruccio
	 */
	public Menu (String t, String d, String i) {
		this.titulo = t;
		this.descripcion = d;
		this.instruccion = i;
	}

	// -- Impresiones -- \\

	/**
	 * Imprime el titulo actual.
	 */
	public void impTitulo() {
		System.out.print("\033[H\033[2J");
    	System.out.flush(); 

		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println();
		System.out.println("    >>>>        " + titulo.toUpperCase() + "        <<<<");
		System.out.println();
		System.out.println();
	}

	/**
	 * Imprime la descripcion actual.
	 */
	public void impDes() {
		System.out.println("    ----");
		System.out.println(descripcion);
		System.out.println("    ----");
		System.out.println();
	}

	/**
	 * Imprime la instruccion actual.
	 */
	public void impIns() {
		System.out.println("** " + instruccion + " **");
		System.out.println();
	}

	/**
	 * Imprime el mensaje de error pasado como parametro.
	 * @param s el mensaje de error.
	 */
	public void impError(String s) {
		System.out.println("error: " + s);
		System.out.println();
		enterParaContinuar();
	}

	/**
	 * Imprime el aviso pasado como parametro.
	 * @param s el aviso.
	 */
	public void impAviso(String s) {
		System.out.println();
		System.out.println(">" + s + "<");
		System.out.println();
		enterParaContinuar();
	}

	/**
	 * Imprime la opcion pasada como parametro con el numero especificado.
	 * @param i el numero de opcion.
	 * @param s la opcion.
	 */
	public void impOpc(int i, String s) {
		System.out.println(" " + (i+1) + ". " + s );
	}

	/**
	 * Imprime la despedida del programa.
	 */
	public void impDespedida() {
		titulo = "Salir";
		descripcion = "Hasta pronto";

		impTitulo();
		impDes();

		enterParaContinuar();

		System.out.print("\033[H\033[2J");  
    	System.out.flush(); 
	}

	// -- Inputs -- \\

	/**
	 * Pregunta por entrada al usuario con un pequeno mensaje.
	 * @param s el mensaje que vera el usuario.
	 * @return la entrada del usuario.
	 */
	public String input(String s) {
		scanner = new Scanner(System.in);
		String next = "";

		do {
			impTitulo();
			impDes();
			impIns();

			System.out.print(s + ": ");
			
			try {
				next = scanner.nextLine();
			//^D
			} catch (NoSuchElementException ex) {
				System.exit(0);
			}
		} while (next.equals(""));


		return next;
	}

	/**
	 * Pregunta por entrada de un numero entero al usuario con un pequeno
	 * mensaje.
	 * @param s el mensaje que vera el usuario.
	 * @return la entrada del usuario.
	 */
	public double inputDouble(String s) {
		boolean found;
		String in = "";
		double val = 0;

		do {
			found = false;
			
			System.out.print(s + ": ");

			//^D
			try {
				in = scanner.next();
			} catch (NoSuchElementException ex) {
				System.exit(0);
			}

			try {
				val = Double.parseDouble(in);
				found = true;
			} catch (Exception ex) {
				impError("entrada invalida");
			}
		} while (!found);
		return val;
	}

	/**
	 * Pregunta por entrada de un número entero al usuario con un pequeño
	 * mensaje.
	 * @param s el mensaje que vera el usuario.
	 * @return la entrada del usuario.
	 */
	public int inputInt(String s) {
		boolean found;
		String in = "";
		int val = 0;

		do {
			found = false;
			System.out.print(s + ": ");

			//^D
			try {
				in = scanner.next();
			} catch (NoSuchElementException ex) {
				System.exit(0);
			}

			try {
				val = Integer.parseInt(in);
				found = true;
			} catch (Exception ex) {
				impError("entrada invalida");
			}
		} while (!found);
		return val;
	}

	/**
	 * Pregunta por entrada de un número entero dentro de las opciones del menu
	 * al usuario con un pequeño mensaje.
	 * El valor proporcionado debe de estar entre el rango especificado
	 * @param s el mensaje que vera el usuario.
	 * @param min el valor minimo
	 * @param max el valor maximo
	 * @return la entrada del usuario.
	 */
	public int inputInt(String s, int min, int max) {
		boolean found;
		String in = "";
		int val = 0;

		do {
			found = false;

			impTitulo();
			impDes();
			impIns();
			
			System.out.println();
			System.out.print(s + "(" + min + "-" + max + "): ");

			//^D
			try {
				in = scanner.next();
			} catch (NoSuchElementException ex) {
				System.exit(0);
			}

			try {
				val = Integer.parseInt(in);
				if (val >= min && val <= max)
					found = true;
				else
					throw new IndexOutOfBoundsException("opcion invalida");
			} catch (IndexOutOfBoundsException ex) {
				impError(ex.getMessage());
			} catch (Exception ex) {
				impError("opcion invalida");
			}
		} while (!found);
		return val;
	}

	/**
	 * Pregunta por entrada de un número entero dentro de las opciones del menu
	 * al usuario con un pequeño mensaje.
	 * El valor proporcionado debe de estar entre las opciones del menu
	 * @param s el mensaje que vera el usuario.
	 * @return la entrada del usuario.
	 */
	public int inputIntOpc(String s) {
		boolean found;
		String in = "";
		int val = 0;

		do {
			found = false;
			
			impTitulo();
			impDes();
			impIns();
			for (int i = 0; i < opciones.length; i++)
				impOpc(i, opciones[i]);

			System.out.println();
			System.out.print(s + "(1-" + opciones.length + "): ");

			//^D
			try {
				in = scanner.next();
			} catch (NoSuchElementException ex) {
				System.exit(0);
			}

			try {
				val = Integer.parseInt(in);
				if (val >= 1 && val <= opciones.length)
					found = true;
				else
					throw new IndexOutOfBoundsException("la opcion elegida no existe");
			} catch (IndexOutOfBoundsException ex) {
				impError(ex.getMessage());
			} catch (Exception ex) {
				impError("opcion invalida");
			}
		} while (!found);
		return val - 1;
	}

	/**
	 * Activa un estado de espera hasta que se presione la tecla enter.
	 */
	public void enterParaContinuar() {
		System.out.println();

		System.out.print("    .. Presione enter para continuar ..");
		try {
			System.in.read();
		} catch (Exception ex) { }
	}

	/**
	 * Asigna el titulo.
	 * @param t el titulo.
	 */
	public void setTitulo(String t) {
		titulo = t;
	}
	/**
	 * Asigna la descripcion.
	 * @param d la descripcion.
	 */
	public void setDes(String d) {
		descripcion = d;
	}
	/**
	 * Asigna la instruccion.
	 * @param i la instruccion.
	 */
	public void setIns(String i) {
		instruccion = i;
	}

	/**
	 * Regresa el titulo actual.
	 * @return el titulo actual.
	 */
	public String getTitulo() {
		return titulo;
	}
	/**
	 * Regresa la descripcion actual.
	 * @return la descripcion actual.
	 */
	public String getDes() {
		return descripcion;
	}
	/**
	 * Regresa la instruccion actual.
	 * @return la instruccion actual.
	 */
	public String getIns() {
		return instruccion;
	}
}
