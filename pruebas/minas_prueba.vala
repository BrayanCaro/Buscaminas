void tablero_con_bombas () {
  Test.add_func ("/1_bomba", () => {
    var tab = new Tablero.Tablero(11,11,1);
    
    assert (true);
  });
  Test.add_func ("/10_bombas", () => {
    //  var tab = new Tablero.Tablero(12,12,10);
    assert (true);
  });
}

void main (string[] args) {
  Test.init (ref args);
  stdout.printf ("crea tablero con:");
  tablero_con_bombas ();
  Test.run ();
}