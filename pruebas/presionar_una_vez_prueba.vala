void presionar_una_vez () {
  Test.add_func ("/el_primer_movimiento_es_valido", () => {
      var tablero = new Tablero(20,20,1);

      tablero.presionar(2,2);
      assert (tablero.getEstado () == Estado.JUGANDO);
      tablero = new Tablero(7,19,50);
      tablero.presionar(5,11);
      assert (tablero.getEstado () == Estado.JUGANDO);
      tablero = new Tablero(8,12,90);
      tablero.presionar(4,2);
      assert (tablero.getEstado () == Estado.JUGANDO);
      tablero = new Tablero(5,10,30);
      tablero.presionar(0,9);
      assert (tablero.getEstado () == Estado.JUGANDO);
  });
}

void main (string[] args) {
  Test.init (ref args);
  presionar_una_vez ();
  Test.run ();
}