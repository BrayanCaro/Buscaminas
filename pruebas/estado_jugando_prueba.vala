void tablero_jugando () {
  Test.add_func ("/crea_tablero_con_estado_JUGANDO", () => {
    var tab = new Tablero(11,6,10);
    assert(tab.getEstado() == Estado.JUGANDO);
    tab = new Tablero(18,10,35);
    assert(tab.getEstado() == Estado.JUGANDO);
    tab = new Tablero(25,14,75);
    assert(tab.getEstado() == Estado.JUGANDO);
  });
}

void main (string[] args) {
  Test.init (ref args);
  tablero_jugando ();
  Test.run ();
}