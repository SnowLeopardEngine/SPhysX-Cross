#!/bin/bash

cmake -S . -B build_macosx_release -G "Xcode"
cmake --build build_macosx_release --config release -j 8