void presionar () {
  Test.add_func ("/presiona_la_casilla_de_un_tablero_sin_ploblemas", () => {
    try { 
      var tablero = new Tablero(20,20,1);
    } catch (Error e) {
      assert_not_reached ();
    }
    try { 
      var tablero = new Tablero(20,20,1);
    } catch (Error e) {
      assert_not_reached ();
    }
    assert (true);
  });
}

void main (string[] args) {
  Test.init (ref args);
  presionar ();
  Test.run ();
}