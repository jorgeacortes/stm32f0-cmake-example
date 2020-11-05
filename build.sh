#!/bin/bash
set -e

if [ ! -d "build" ]; then
  mkdir build
fi
cd build

cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE:PATH="CMake/toolchain.cmake" ..

make