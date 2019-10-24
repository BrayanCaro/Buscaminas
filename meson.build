project('buscaminasvala','vala','c')

# iniciamos el ejecutabe
deps = [ dependency('glib-2.0'), dependency('gtk+-3.0'),
  dependency('json-glib-1.0') ]
sources = files(
  'src/vista/Menu.vala',
  'src/modelo/Tablero.vala'
)
exe = executable('buscaminas', sources: sources, dependencies : deps)
