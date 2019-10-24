void propiedades_del_tablero_f_c_m(){
  Test.add_func ("/propiedades_del_tablero_f_c_m", () => {

    var tab = new Tablero(11,6,10);
    assert (tab.obtenerFilas () == 11);
    assert (tab.obtenerColumnas () == 6);
    assert (tab.obtenerMinas () == 10);

    tab = new Tablero(1,6,1);
    assert (tab.obtenerFilas () == 1);
    assert (tab.obtenerColumnas () == 6);
    assert (tab.obtenerMinas () == 1);

    tab = new Tablero(13,20,40);
    assert (tab.obtenerFilas () == 13);
    assert (tab.obtenerColumnas () == 20);
    assert (tab.obtenerMinas () == 40);

  });
}

void main (string[] args) {
  Test.init (ref args);
  propiedades_del_tablero_f_c_m ();
  Test.run ();
}