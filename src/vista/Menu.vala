protected errordomain ErrorTipo2{
  DATOS_INCORRECTOS
}

public class Menu{
  private bool tablero; // Se sustituye por un objeto de tipo tablero.
  //  Dificultad 
  //    Facil     11*6 con 10 bombas 
  //    Media     18*10 con entre 35 bombas 
  //    Dificil   25*14 con 75 bombas 

    /*
    * Crea un menú.
    */
  public Menu(){
    this.tablero = false;
    bienvenida();
  }

  /*
  * Muestra un menú de bienvenida.
  */
  private void bienvenida(){
    bool bandera = true;
    do{
      //  print("\033[40m");
    stdout.printf("\t\t\tBuscaminas\nEscoge una opción: \n1. Jugar partida nueva.\n\ta)Fácil: 11x6 con 10 bombas.\n\tb)Medio: 18x10 con 35 bombas.\n\tc)Difícil: 25x14 con 75 bombas.\n   En caso de jugar una nueva partida escribe 1x, con x el nivel de dificultad del juego.\n2. Continuar con la partida.\n3. Salir.\n");
    string opcion = stdin.read_line()._strip();
    opcion = verificacionDeDatos(opcion);

      switch (opcion) {
        case "a":
          {
            //  Inicializar tablero de 11x6 con 10
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
          bandera = false;
          break;
        }
        default:
          stdout.printf("\t\t\033[47m \033[1;30m Esa opción no existe. \033[0m \n\n");
        break;
      }
      //  print("\033[0m");
    } while (bandera);    
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

  public static void main (){
    Tablero tan = new Tablero(11,8,10);
    tan.to_string();
    var manuPrueba = new Menu();

  }  
}
