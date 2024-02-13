#!/bin/bash

# create tmp folder
tmpFolder="tmp"
mkdir -p "$tmpFolder"

# setup download url link and file name
url="https://github.com/SnowLeopardEngine/SPhysX-Cross/releases/download/Prebuilt-macosx-arm64/Prebuilt_macosx_arm64.zip"
zipFileName="Prebuilt_macosx_arm64.zip"

# prepare folder names
downloadDirectory="$tmpFolder"
extractDirectory="$downloadDirectory"

# if .zip not exist.
if [ ! -f "$downloadDirectory/$zipFileName" ]; then
    echo "Start downloading PhysX Prebuilt SDK..."
    # download the file
    curl -o "$downloadDirectory/$zipFileName" "$url" -L
    echo "Finished downloading PhysX Prebuilt SDK."
fi

if [ ! -d "$extractDirectory/Prebuilt" ]; then
    echo "Start extracting PhysX Prebuilt SDK..."
    # extract file
    unzip -o "$downloadDirectory/$zipFileName" -d "$extractDirectory"
    echo "Finished extracting PhysX Prebuilt SDK."
fi

if [ ! -d "Prebuilt" ]; then
    # copy prebuilt files
    cp -r "$extractDirectory/Prebuilt" "Prebuilt"
    echo "Finished copying PhysX Prebuilt SDK to project root."
fi