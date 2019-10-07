public class Menu{
  private bool tablero; // Se sustituye por un objeto de tipo tablero.
  //  Dificultad 
  //    Facil     11*6 con 10 bombas 
  //    Media     18*10 con entre 35 bombas 
  //    Dificil   25*14 con 75 bombas 

  public Menu(){
    this.tablero = false;
    bienvenida();
  }

  private void bienvenida(){
    int opcion = 0;
    bool bandera = true;
    do{
    stdout.printf("\t\t\tBuscaminas\nEscoge una opción: \n1. Jugar partida nueva.\n2. Continuar con la partida.\n3. Salir.\n");
    stdin.scanf("%d", out opcion);
      switch (opcion) {
        case 1:
          {
            inicializarTablero();
            break;
          }
        case 2:
        {
          print("Falta guardar partida.\n");
          break;
        }
        case 3:
        {
          bandera = false;
          break;
        }
        default:
          stdout.printf("Esa opción no existe.\n");
        break;
      }
    } while (bandera);    
  }
  /*
  * Método que escanea los datos necesarios para el tablero. Falla si metes un carácter.    
   */
  private void escaneoDeDatos(){
    int filas= 0;
    int columnas=0; 
    int bombas=0;
      List<int> datos = new List<int>();    
      stdout.printf("Ingresa el número de filas: ");
      stdin.scanf("%d", out filas);
      datos.append(filas);
      stdout.printf("Ingresa el número de columnas: ");
      stdin.scanf("%d", out columnas);
      datos.append(columnas);
      stdout.printf("Ingresa el número de bombas: ");
      stdin.scanf("%d", out bombas);
      datos.append(bombas);
      if (filas == 0 || columnas == 0 || bombas == 0){
        stdout.printf("Por favor ingresa números.\n"); 
      }      
      if (!verificacionDeDatos(filas,columnas,bombas)){
        for (int i = 0; i < datos.length(); i++) {
           datos.remove_all(datos.nth_data(i));
         }
        escaneoDeDatos();
      }
  }

  /* 
  * Verifica que los datos del tablero estén en un rango adecuado.
  * @return true si los datos son correctos (e imprime los datos), false si no es así.
  */
  private bool verificacionDeDatos(int filas, int columnas, int bombas) 
  requires(filas>7 && filas<20)
  requires(columnas>7 && filas<20)
  requires(bombas>4 && bombas<80){
    print("Escogiste:\n %i filas\n %i columnas\n %i bombas\n", filas, columnas, bombas);
    return true;
  }
  
  void inicializarTablero(){    
      escaneoDeDatos(); 
    //  Escaneados los datos, crear el nuevo tablero.
  }




  public static void main (){
    var manuPrueba = new Menu();
  }  
}
