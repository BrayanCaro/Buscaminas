package buscaminas.util;

import buscaminas.modelo.TableroBuscaminas;

import java.io.File;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.FileInputStream;

public class TableroBuscaminasIO {
	private String ruta;

	public TableroBuscaminasIO(String ruta) throws IllegalArgumentException {
		File f = new File(ruta);
		if (!f.exists() || !f.isDirectory())
			throw new IllegalArgumentException("Ruta invalida");
		this.ruta = ruta;
	}

	private String getRutaArchivo(int i) {
		return this.ruta + "/" + i + ".tb";
	}

	private String getNombre() throws IOException {
		for (int i = 0; i < 64; i++)
			if (!new File(this.getRutaArchivo(i)).exists())
				return this.getRutaArchivo(i);
		throw new IOException("Numero maximo de tableros alcanzado");
	}

	public void guardar(TableroBuscaminas t) throws IOException {
		ObjectOutputStream out = null;

		try {
			String n = this.getNombre();
			FileOutputStream f = new FileOutputStream(n);
			out = new ObjectOutputStream(f);

			out.writeObject(t);
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (out != null) out.close();
		}
	}

	public TableroBuscaminas cargar(int i) throws IOException, ClassNotFoundException {
		ObjectInputStream in = null;

		try {
			String n = this.getRutaArchivo(i);
			FileInputStream f = new FileInputStream(n);
			in = new ObjectInputStream(f);

			TableroBuscaminas t = (TableroBuscaminas)in.readObject();
			this.borrar(i);
			return t;
		} catch (IOException|ClassNotFoundException ex) {
			throw ex;
		} finally {
			if (in != null) in.close();
		}
	}

	private void borrar(int i) {
		String n = this.getRutaArchivo(i);
		File f = new File(n);
		f.delete();
	}

	private TableroBuscaminas[] purify(TableroBuscaminas[] t) {
		TableroBuscaminas[] purificados;
		int tableros = 0;

		//cuenta cuantos no null hay
		for (int i = 0; i < t.length; i++)
			if (t[i] != null) tableros++;

		purificados = new TableroBuscaminas[tableros];

		//agrega todos los no null a purificados
		for (int i = 0, j = 0; i < t.length; i++)
			if (t[i] != null) purificados[j++] = t[i];

		return purificados;
	}

	public TableroBuscaminas[] getOpciones() {
		TableroBuscaminas[] t = new TableroBuscaminas[64];

		for (int i = 0; i < 64; i++)
			try {
				t[i] = this.cargar(i);
			} catch (IOException|ClassNotFoundException ex) {
				continue;
			} 

		return this.purify(t);
	}
}
