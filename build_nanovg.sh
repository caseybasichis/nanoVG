#!/bin/bash

pushd lib/nanovg
premake4 gmake
cd build
make config=release nanovg example_gles3
popd

./generate_signatures.py
