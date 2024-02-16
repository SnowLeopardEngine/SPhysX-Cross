#!/bin/bash

# create tmp folder
tmpFolder="tmp"
mkdir -p "$tmpFolder"

# setup download url link and file name
url="https://github.com/SnowLeopardEngine/SPhysX-Cross/releases/download/Prebuilt-linux-x86_64/Prebuilt_linux_x86_64.tar.gz"
gzipFileName="Prebuilt_linux_x86_64.tar.gz"

# prepare folder names
downloadDirectory="$tmpFolder"
extractDirectory="$downloadDirectory"

# if .zip not exist.
if [ ! -f "$downloadDirectory/$gzipFileName" ]; then
    echo "Start downloading PhysX Prebuilt SDK..."
    # download the file
    curl -o "$downloadDirectory/$gzipFileName" "$url" -L
    echo "Finished downloading PhysX Prebuilt SDK."
fi

if [ ! -d "$extractDirectory/Prebuilt" ]; then
    echo "Start extracting PhysX Prebuilt SDK..."
    # extract file
    tar -xzvf "$downloadDirectory/$gzipFileName" -C "$extractDirectory"
    echo "Finished extracting PhysX Prebuilt SDK."
fi

if [ ! -d "Prebuilt" ]; then
    # copy prebuilt files
    cp -r "$extractDirectory/Prebuilt" "Prebuilt"
    echo "Finished copying PhysX Prebuilt SDK to project root."
fi

