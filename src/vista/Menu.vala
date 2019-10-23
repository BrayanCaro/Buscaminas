protected errordomain ErrorTipo2{
  DATOS_INCORRECTOS
}

public class Menu{
  private Tablero tablero; // Se sustituye por un objeto de tipo tablero.
  //  Dificultad 
  //    Facil     11*6 con 10 bombas 
  //    Media     18*10 con entre 35 bombas 
  //    Dificil   25*14 con 75 bombas 

    /*
    * Crea un menú.
    */
  public Menu(){
    this.tablero = null;
    while (bienvenida())
    jugar();
    if (this.tablero != null)
      this.tablero.to_string();
  }

  /*
  * Muestra un menú de bienvenida.
  */
  private bool bienvenida(){
	while (true) {
      //  print("\033[40m");
    stdout.printf("\t\t\tBuscaminas\nEscoge una opción: \n1. Jugar partida nueva.\n\ta)Fácil: 11x6 con 10 bombas.\n\tb)Medio: 18x10 con 35 bombas.\n\tc)Difícil: 25x14 con 75 bombas.\n   En caso de jugar una nueva partida escribe 1x, con x el nivel de dificultad del juego.\n2. Continuar con la partida.\n3. Salir.\n");
    string opcion = stdin.read_line()._strip();
    opcion = verificacionDeDatos(opcion);

      switch (opcion) {
        case "a":
        {
          this.tablero = new Tablero(11,6,10);
          break;
        }
        case "b":
        {
          //  Inicializar tablero de 18x10 con 35
          break;
        }
        case "c":
        {
          //  Inicializar tablero de 25x14 con 75
          break;
        }
        case "2":
        {
          print("Falta guardar partida.\n");
          break;
        }
        case "3":
        {
          return false;
        }
        default:
        stdout.printf("\t\t\033[47m \033[1;30m Esa opción no existe. \033[0m \n\n");
        break;
      }
    return true;
    }
  }

  /*
  * Verifica que las opciones de dificultad del juego sean correctas.
  * @param dificultad: opción del menú (1a,1b,1c).
  * @return dificultad del juego (a,b,c).
  */
  private string verificacionDeDatos(string dificultad)
  ensures (result.char_count()>= 1){
    //  print("\033[40m");
      string dificultadJuego = "";
    if (dificultad.contains("1")){
        switch(dificultad){
            case "1a":
            {
                stdout.printf("Nivel fácil.\n");
                dificultadJuego = "a";
                break;
            }
            case "1b":
            {
                stdout.printf("Nivel medio.\n");
                dificultadJuego = "b";
                break;
            }
            case "1c":
            {
                stdout.printf("Nivel difícil.\n");
                dificultadJuego = "c";
                break;
            }
        }
    } else {
        dificultadJuego = dificultad;
    }
    //  print("\033[0m");
    return dificultadJuego;
  }

  private void jugar() {
	bool salir = false;
	bool tirando = false;

	string mensaje1 = "\t\t\tPartida en curso\n Escoge una opcion:\n1. " +
		"Tirar\n2. Guardar\n3. Salir\n";
	string mensaje2 = "\t\t\tPartida en curso\n Introduzca las coordenadas " +
		"separadas por un espacio (e.g. 1 2)\n";
	string mensaje3 = "\t\t\tFelicidades\nHaz ganado esta partida. " +
		"Introduzca cualquier valor para regresar al menu principal\n";
	string mensaje4 = "\t\t\tRaios\nHaz perdido esta partida. " +
		"Introduzca cualquier valor para regresar al menu principal\n";

	while (!salir) {
		string carita;
		if (tirando) {
			carita = ":o";
			stdout.printf("\t\t\t\t%s", carita);
			tablero.to_string();
			stdout.printf(mensaje2);
			string opcion = stdin.read_line()._strip();

			var coords = opcion.split(" ");

			int64 i;
			int64 j;
			if (coords.length != 2) {
				stdout.printf("Entrada invalida\n");
				continue;
			}
			if (!int64.try_parse(coords[0], out i)) {
				stdout.printf("Entrada invalida\n");
				continue;
			}
			if (!int64.try_parse(coords[1], out j)) {
				stdout.printf("Entrada invalida\n");
				continue;
			}

			int k = (int)i;
			stdout.printf("%d", k);
			// this.tablero.presionar((int)i, (int)j);
			tirando = false;
		} else {
			string mensaje = mensaje1;
			if (this.tablero.getEstado() == Estado.GANADO) {
				mensaje = mensaje3;
				carita = "B)";
			} else if (this.tablero.getEstado() == Estado.PERDIDO) {
				mensaje = mensaje4;
				carita = "x(";
			}
			else carita = ":)";

			stdout.printf("\t\t\t\t%s", carita);
			tablero.to_string();
			stdout.printf(mensaje);
			string opcion = stdin.read_line()._strip();

			switch (opcion) {
				case "1": tirando = true; break;
				case "2": stdout.printf("proximamentexdxd\n"); break; // TODO
				case "3": salir = true; break;
				default: stdout.printf("Entrada invalida\n"); break;
			}
		}

	}
  }

  public static void main (){
    var manuPrueba = new Menu();
  }  
}
