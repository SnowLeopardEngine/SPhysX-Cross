#!/bin/bash

mkdir -p build_linux_release
cd build_linux_release
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j 8
