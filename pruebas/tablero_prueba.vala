using Tablero;

void tablero_de_tam_negativo () {
  stdout.printf ("| Se suelta una excepción cuando los parametros son menores o iguales a 0\n");
  Test.add_func ("/crea/tablero_de_tam_muy_chico", () => {
    try {
      var tablero = new Tablero.Tablero(1,1,0);
      tablero = new Tablero.Tablero(-21,-1,23);
      assert_not_reached ();
    } catch (ParametrosInvalidos e) {
      assert (true );
    }
    try {
      var tablero = new Tablero.Tablero(1,0,1);
      tablero = new Tablero.Tablero(-2,-231,-2);
      assert_not_reached ();

    } catch (ParametrosInvalidos e) {
      assert (true );
    }
    try {
      var tablero = new Tablero.Tablero(0,1,1);
      tablero = new Tablero.Tablero(-1,-321,-2);
      assert_not_reached ();
    } catch (ParametrosInvalidos e) {
      assert (true );
    }
  });
}

void main (string[] args) {
  Test.init (ref args);
  tablero_de_tam_negativo ();
  Test.run ();
}