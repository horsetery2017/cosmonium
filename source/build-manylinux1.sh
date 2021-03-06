#!/bin/bash

SOURCE=/cosmonium/source

URL=https://github.com/cosmonium/panda3d/releases/download/
VERSION=cosmonium-v1.10.6.dev76

PANDA3D=panda3d-1.10.6-1.x86_64.rpm
EXTRA=extra-includes.zip

cd $SOURCE
if [ ! -e $PANDA3D ]; then
    curl -L $URL/$VERSION/$PANDA3D -o $PANDA3D
fi
if [ ! -e $EXTRA ]; then
    curl -L $URL/$VERSION/$EXTRA -o $EXTRA
fi

PYTHON_DIR=/opt/python/cp37-cp37m
PYTHON_BIN=$PYTHON_DIR/bin
PYTHON_INC=$PYTHON_DIR/include/python3.7m
PYTHON=$PYTHON_BIN/python
PIP=$PYTHON_BIN/pip
CMAKE=$PYTHON_BIN/cmake

yum install -y rpmbuild fakeroot
$PIP install cmake
rpm -i --nodeps $SOURCE/$PANDA3D

cd /usr/include
unzip $SOURCE/$EXTRA

cd $SOURCE
$PYTHON ../tools/p3d_module_builder/build.py --clean --cmake $CMAKE --python-incdir $PYTHON_INC
