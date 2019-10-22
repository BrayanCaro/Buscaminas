project('buscaminasvala','vala','c')

# inciamos el test
sources = files(
  'pruebas/tablero_prueba.vala',
  'src/modelo/Tablero.vala'
)
test_unit = 'tablero_prueba'
deps = [dependency('glib-2.0'),dependency('gtk+-3.0'), dependency('gee-0.8')]
exe = executable(test_unit, sources: sources, dependencies : deps)
# anexamos el test
test(test_unit, exe)

#
sources = files(
  'pruebas/minas_prueba.vala',
  'src/modelo/Tablero.vala'
)
test_unit = 'minas_prueba'
deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
exe = executable(test_unit, sources: sources, dependencies : deps)
#
test(test_unit, exe)

# #
# sources = files('pruebas/unit-test-gtk.vala')
# test_unit = 'prueba2'
# deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
# exe = executable(test_unit, sources: sources, dependencies : deps)
# #
# test(test_unit, exe)

# #
# sources = files('pruebas/unit-test-gtk.vala')
# test_unit = 'prueba3'
# deps = [dependency('glib-2.0'), dependency('gtk+-3.0'), dependency('gee-0.8')]
# exe = executable(test_unit, sources: sources, dependencies : deps)
# #
# test(test_unit, exe)

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