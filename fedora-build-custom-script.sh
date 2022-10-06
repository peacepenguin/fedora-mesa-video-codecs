#! /bin/sh -x
dnf download --source mesa-libGL
rpmdev-extract ./mesa-*.src.rpm
mkdir ./mesa
mv mesa-*.src/* ./mesa/

nl=$'\n'
sed -i 's*-Dvulkan-layers=device-select \\*-Dvulkan-layers=device-select \\'"\\${nl}"'  -Dvideo-codecs=h264dec,h264enc,h265dec,h265enc,vc1dec \\*' mesa/mesa.spec

