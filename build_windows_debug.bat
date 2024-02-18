@echo off

mkdir build_windows_debug
cd build_windows_debug
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake --build . -j 8