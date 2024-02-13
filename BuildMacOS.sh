#!/bin/bash

cmake -S . -B build_macos -G "Xcode"
cmake --build build_macos --config release -j 8