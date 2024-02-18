@echo off

mkdir build_windows_release
cd build_windows_release
cmake ..
cmake --build . --config release -j 8