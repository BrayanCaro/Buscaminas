void tablero_de_tam_negativo () {
  Test.add_func ("/crea_un_tablero", () => {
    assert (true);
  });
}

void main (string[] args) {
  Test.init (ref args);
  tablero_de_tam_negativo ();
  Test.run ();
}