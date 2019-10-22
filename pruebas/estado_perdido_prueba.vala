void tablero_perdido(){
  Test.add_func ("/presiona_todas_las_casillas_termina_con_estado_PERDIDO", () => {
    var tab = new Tablero(11,6,10);
    for (int i = 0; i < 11; i++) {
      for (int j = 0; j < 6; j++) {
        tab.presionar(i,j);
      }
    }
    assert(tab.getEstado() == Estado.PERDIDO);
    tab = new Tablero(18,10,35);
    for (int i = 0; i < 18; i++) {
      for (int j = 0; j < 10; j++) {
        tab.presionar(i,j);
      }
    }
    assert(tab.getEstado() == Estado.PERDIDO);
    tab = new Tablero(25,14,75);
    for (int i = 0; i < 25; i++) {
      for (int j = 0; j < 14; j++) {
        tab.presionar(i,j);
      }
    }
    assert(tab.getEstado() == Estado.PERDIDO);
  });
}

void main (string[] args) {
  Test.init (ref args);
  tablero_perdido ();
  Test.run ();
}