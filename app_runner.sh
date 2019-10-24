#!/bin/bash

if ! [ -d "build/" ]; then
  meson build
fi
cd build
ninja &> /dev/null
./buscaminas