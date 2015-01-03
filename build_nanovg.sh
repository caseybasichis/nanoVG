#!/bin/bash

cd lib/nanovg
premake4 gmake
cd build
make config=release nanovg example_gles3
