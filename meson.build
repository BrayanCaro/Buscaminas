project('buscaminasvala','vala','c')

# iniciamos el ejecutabe
deps = [dependency('glib-2.0'),dependency('gtk+-3.0'), dependency('gee-0.8')]
sources = files(
  'src/vista/Menu.vala',
  'src/modelo/Tablero.vala'
)
exe = executable('app', sources: sources, dependencies : deps)

# inciamos el test
sources = files(
  'pruebas/presionar_prueba.vala',
  'src/modelo/Tablero.vala'
)
test_unit = 'presionar_prueba'
deps = [dependency('glib-2.0'),dependency('gtk+-3.0'), dependency('gee-0.8')]
exe = executable(test_unit, sources: sources, dependencies : deps)
# anexamos el test
test(test_unit, exe)

#
sources = files(
  'pruebas/presionar_una_vez_prueba.vala',
  'src/modelo/Tablero.vala'
)
test_unit = 'presionar_una_vez_prueba'
deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
exe = executable(test_unit, sources: sources, dependencies : deps)
#
test(test_unit, exe)

#
sources = files(
  'pruebas/estado_perdido_prueba.vala',
  'src/modelo/Tablero.vala'
)
test_unit = 'estado_perdido_prueba'
deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
exe = executable(test_unit, sources: sources, dependencies : deps)
#
test(test_unit, exe)

#
sources = files(
  'pruebas/estado_jugando_prueba.vala',
  'src/modelo/Tablero.vala'
)
test_unit = 'estado_jugando_prueba'
deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
exe = executable(test_unit, sources: sources, dependencies : deps)
#
test(test_unit, exe)

# #
# sources = files('pruebas/unit-test-gtk.vala')
# test_unit = 'prueba4'
# deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
# exe = executable(test_unit, sources: sources, dependencies : deps)
# #
# test(test_unit, exe)

# #
# sources = files('pruebas/unit-test-gtk.vala')
# test_unit = 'prueba5'
# deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
# exe = executable(test_unit, sources: sources, dependencies : deps)
# #
# test(test_unit, exe)