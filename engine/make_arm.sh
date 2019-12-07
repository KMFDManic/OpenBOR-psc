#!/usr/bin/env bash
rm -rf ./build_arm
mkdir -p build_arm

cd ./build_arm
cmake -DCMAKE_TOOLCHAIN_FILE=../PSCtoolchain.cmake  ..
make -j4

cmake -DCMAKE_TOOLCHAIN_FILE=../PSCtoolchain.cmake -D_INPUTFIX=1 ..
make -j4
cd ..

