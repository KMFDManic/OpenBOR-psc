#!/usr/bin/env bash
rm -rf ./build_x64
mkdir -p build_x64

cd ./build_x64
cmake ..
make -j4
cd ..

