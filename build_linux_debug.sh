#!/bin/bash

mkdir -p build_linux_debug
cd build_linux_debug
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake --build . -j 8
