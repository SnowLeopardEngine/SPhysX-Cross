#!/bin/bash

cmake -S . -B build_macosx_debug -G "Xcode"
cmake --build build_macosx_debug --config debug -j 8