void presionar_una_vez () {
  Test.add_func ("/el_primer_movimiento_es_valido", () => {
      var tablero = new Tablero(20,20,1);
      try {
        tablero.presionar(2,2);
      } catch (Error e) {}
      assert (tablero.getEstado () == Estado.JUGANDO);
      tablero = new Tablero(7,19,50);
      try {
        tablero.presionar(5,11);
      } catch (Error e) {}
      assert (tablero.getEstado () == Estado.JUGANDO);
      tablero = new Tablero(8,12,90);
      try {
        tablero.presionar(4,2);
      } catch (Error e) {}
      assert (tablero.getEstado () == Estado.JUGANDO);
      tablero = new Tablero(5,10,30);
      try {
        tablero.presionar(0,9);
      } catch (Error e) {}
      assert (tablero.getEstado () == Estado.JUGANDO);
  });
}

void main (string[] args) {
  Test.init (ref args);
  presionar_una_vez ();
  Test.run ();
}