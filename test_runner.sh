#!/bin/bash

if ! [ -d "build/" ]; then
  meson build
fi
cd build

if [ "$1" == "" ]; then
  meson test --repeat=1
else
  meson test --repeat=$1
fi

total_test=4
tests_fail_and_pass=`cat meson-logs/testlog.json | grep -o "returncode\"\: -\?[06]" | grep -o "\-\?[06]"`
time_per_test=`cat meson-logs/testlog.json | grep -o "duration\"\: 0.\{5\}" | grep -o "0.\{5\}"`

test_passed=0
test_failed=0
for test in $tests_fail_and_pass
do
  if [ $test == "0" ]; then
    ((test_passed++))
  else
    ((test_failed++))
  fi
done
echo "Pasaron:" $test_passed " pruebas"
echo "Fallarón:" $test_failed " pruebas"

averange=0
for test in $time_per_test
do
  averange=$(bc -l <<<"${test}+${averange}")
done
echo "El promedio de tiempo por prueba fue " $(bc -l <<<"${averange}/${total_test}") " seg"