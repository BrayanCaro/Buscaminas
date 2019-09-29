/**
 * Clase MiHilo para representar un reloj.
 * Objetivo. Imitar el comportamiento de un cronometro.
 * @author Brayan Martinez Santana y Jose Luis García Santamaria
 * @version Primera version, Sabado 8 de Diciembre, 2018
 */

import java.io.*;
import java.util.Scanner;

public class MiHilo implements Runnable {
String nombreHilo;
String tiempo;

/**
 * Metodo contructor que crea un objeto de la clase MiHilo
 * @param nombre Es el nombre que le daremos al hilo
 */
MiHilo(String nombre){
	nombreHilo = nombre;
}

/**
 * Metodo run para usar al reloj como un hilo
 */
public void run(){
	int nuMin = 0;
	int nuSeg = -1; //El contador de segundos
	int nuHora = 0; //El contador de horas
	try {
		for (int i =0; i<86400; i++) {

			if(nuSeg < 59) { //Si no es el ultimo segundo
				nuSeg++; //Incrementamos los segundos
			}else{
				if(nuMin < 60) { //Si no es el ultimo minuto
					nuSeg = 0; //Pasamos a 0 los segundos
					nuMin++;
				}else{ //Incremento de numero de horas
					nuHora++;
					nuMin = 0; //Pasamos a 0 los minutos
					nuSeg = 0; //Pasamos a 0 los segundos
				}
			}
			Thread.sleep(1000);
		}
	} catch (Exception e) {
	} finally {
		tiempo = formato(nuHora,nuMin,nuSeg);
	}
}

/**
 * Metodo que regresa una hora determinada
 * @return El tiempo en formato de String
 * @param hora Indica las horas
 * @param minuto Indica los minutos
 * @param segundo Indica los segundos
 */
public static String formato(int hora,int minuto, int segundo){
	String salida = "";

	if (hora < 10) {
		salida += "0" + hora;
	} else {
		salida += hora;
	}
	salida += ":";
	if (minuto < 10) {
		salida += "0" + minuto;
	} else {
		salida += minuto;
	}
	salida += ":";
	if (segundo < 10) {
		salida += "0" + segundo;
	} else {
		salida += segundo;
	}
	return salida;
}

}
