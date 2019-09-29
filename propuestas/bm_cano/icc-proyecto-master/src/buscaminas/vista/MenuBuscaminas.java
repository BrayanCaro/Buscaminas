package buscaminas.vista;

public class MenuBuscaminas extends Menu {
	/**
	 * Carga el menú principal.
	 * Cambia el título, descripción e instrucción para representar el menú
	 * principal del programa.
	 */
	public void cargarPrincipal() {
		super.titulo = "Menu principal";
		super.descripcion = "Que desea hacer?";
		super.instruccion = "Seleccione la opción deseada";

		super.opciones = new String[3];
		super.opciones[0] = "Jugar nueva partida";
		super.opciones[1] = "Cargar partida guardada";
		super.opciones[2] = "Salir";
	}
}
