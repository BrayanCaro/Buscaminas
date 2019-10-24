public class Menu{
  private Tablero tablero; // Se sustituye por un objeto de tipo tablero.
  //  Dificultad 
  //    Facil     11*6 con 10 bombas 
  //    Media     18*10 con entre 35 bombas 
  //    Dificil   25*14 con 75 bombas 

    /* Crea un menú. */
  public Menu(){
    stdout.printf ("-");
    while (bienvenida())
    jugar();
  }

  /* Muestra un menú de bienvenida. */
  private bool bienvenida(){
    while (true) {
      stdout.printf("\t\t\t\t\tBuscaminas\n\t\tEscoge una opción: \n\t\t1. Jugar partida nueva.\n\t\t\ta)Fácil: 11x6 con 10 bombas.\n\t\t\tb)Medio: 18x10 con 35 bombas.\n\t\t\tc)Difícil: 25x14 con 75 bombas.\n   \t\tEn caso de jugar una nueva partida escribe 1x, con x el nivel de dificultad del juego.\n\t\t2. Continuar con la partida.\n\t\t3. Salir.\n"); string opcion = stdin.read_line()._strip();
      opcion = verificacionDeDatos(opcion);
      switch (opcion) {
        case "a":
        {
          this.tablero = new Tablero(11,6,10);
          return true;
        }
        case "b":
        {
          this.tablero = new Tablero(18,10,35);
          return true;
        }
        case "c":
        {
          this.tablero = new Tablero(25,14,75);
          return true;
        }
        case "2":
        {
        this.tablero = new Tablero(10, 10, 10);
        if (this.tablero.cargar()) {
          print("Partida cargada exitosamente.\n");
          return true;
        } else {
          print("Error al cargar partida.\n");
          this.tablero = null;
        }
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
    }
  }

  /*
  * Verifica que las opciones de dificultad del juego sean correctas.
  * @param dificultad: opción del menú (1a,1b,1c).
  * @return dificultad del juego (a,b,c).
  */
  private string verificacionDeDatos(string dificultad)
  {
      string dificultadJuego = "";
    if (dificultad.contains("1")){
        switch(dificultad){
            case "1a":
            {
                dificultadJuego = "a";
                break;
            }
            case "1b":
            {
                dificultadJuego = "b";
                break;
            }
            case "1c":
            {
                dificultadJuego = "c";
                break;
            }
        }
    } else {
        dificultadJuego = dificultad;
    }

    return dificultadJuego;
  }

  /* Juega un buscaminas. */
  private void jugar() {
    bool salir = false;
    bool tirando = false;
    bool finalizada = false;

    string mensaje1 = "\n  Escoge una opcion.\n\t\t---------------------------------------------------\n\t\t| 1 Tira | 2 Guarda | 3 Regresa el menú principal |\n\t\t---------------------------------------------------\n";
    string mensaje2 = "\t Introduce las coordenadas separadas por un espacio\n\t\t\t(e.j. 5 6)\n";
    string mensaje3 = "\t\t 🏆🎉🏆🎉🏆 Felicidades 🏆🎉🏆🎉🏆 \nHaz ganado esta partida. " +
      "Introduce cualquier valor para regresar al menu principal\n";
    string mensaje4 = "\t\tRaios, haz perdido esta partida. 😞 \n" +
      "\t\tIntroduce cualquier valor para regresar al menu principal\n";

    do {

      if (tirando){    
              stdout.printf (mensaje2);
              string opcion = stdin.read_line()._strip();    
              var opciones = opcion.split(" ");  
              int64 i, j;
              if (opciones.length != 2) {
              stdout.printf("\t\t\033[47m \033[1;30mEntrada invalida\033[0m\n");
              continue;
              }
              if (!int64.try_parse(opciones[0], out i)) {
                stdout.printf("\t\t\033[47m \033[1;30mEntrada invalida\033[0m\n");
                continue;
              }
              if (!int64.try_parse(opciones[1], out j)) {
                stdout.printf("\t\t\033[47m \033[1;30mEntrada invalida\033[0m\n");
                continue;
              }
              try{
                this.tablero.presionar((int)j, (int)i);
              } catch(Error e){
                stdout.printf (e.message);
              }
              tirando = false; 

      } else {
              stdout.printf ("\t\t\t\t\tPartida en curso 😁\n");
              tablero.to_string();

              if (this.tablero.getEstado() == Estado.GANADO) {
                stdout.printf ("\t\t\t\t 😎 \n"+mensaje3);
                finalizada = true;
              } else if (this.tablero.getEstado() == Estado.PERDIDO) {
                stdout.printf ("\t\t\t\t 🤯 \n"+mensaje4);
                finalizada = true;
              } else {
              	stdout.printf(mensaje1);
			  }

              string opcion = stdin.read_line()._strip(); 
              if (finalizada) return;

              switch(opcion){
                case "1": tirando = true; break;
                case "2":
						if (tablero.guardar())
							stdout.printf("\t\t\tPartida guardada...");
						else
							stdout.printf("\t\t\tPartida guardada...");
						break;
                case "3": salir = true; break;
                default: stdout.printf("\t\t\033[47m \033[1;30mEntrada invalida\033[0m\n"); break;
              }


      }		

    } while (!salir);
  }

  public static void main (){
    var menuPrueba = new Menu();
  }  
}
