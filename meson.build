project('buscaminasvala','vala','c')

# iniciamos el ejecutabe
deps = [ dependency('glib-2.0'), dependency('gtk+-3.0'),
  dependency('json-glib-1.0') ]
sources = files(
  'src/vista/Menu.vala',
  'src/modelo/Tablero.vala'
)

exe = executable('buscaminas', sources: sources, dependencies : deps)

# Para ejecutar las pruebas

pruebas = [
  'presionar_prueba',
  'presionar_una_vez_prueba',
  'estado_perdido_prueba',
  'estado_jugando_prueba'
  ]

plantilla = 'pruebas/@0@.vala'

foreach prueba : pruebas
  sources = files( plantilla.format(prueba), 'src/modelo/Tablero.vala')
  exe = executable(prueba, sources : sources, dependencies : deps)
  test(prueba, exe)
endforeach
