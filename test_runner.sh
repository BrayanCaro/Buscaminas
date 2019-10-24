#!/bin/bash

meson build
cd build
meson test --repeat=10

var=`cat meson-logs/testlog.json | grep -o "returncode\"\: -\?[06]" | grep -o "\-\?[06]"`

test_passed=0
test_failed=0
for addr in $var
do
  if [ $addr == "0" ]; then
    ((test_passed++))
  else
    ((test_failed++))
  fi
done
echo "Pasaron:" $test_passed " pruebas"
echo "Fallarón:" $test_failed " pruebas"