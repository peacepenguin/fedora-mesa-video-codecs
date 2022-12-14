#!/bin/bash

dnf update --refresh --assumeyes

dnf install dnf-plugins-core cmake libva-utils libva rpm-build --assumeyes

dnf builddep mesa --assumeyes

cd ~
dnf download --source mesa-libGL --assumeyes

srcrpmname=$(dnf info mesa-libGL |grep -m 1 Source | awk -F' : ' '{print $2}')

rpm -i $srcrpmname


## EDIT THE MESA SPEC FILE

cp ~/rpmbuild/SPECS/mesa.spec ~/rpmbuild/SPECS/mesa.spec.bak
sed -i "s*release_number = $srcrelease;*release_number = $targetrelease;*" ~/rpmbuild/SPECS/mesa.spec

nl=$'\n'

sed -i 's*-Dvulkan-layers=device-select \\*-Dvulkan-layers=device-select \\'"\\${nl}"'  -Dvideo-codecs=h264dec,h264enc,h265dec,h265enc,vc1dec \\*' ~/rpmbuild/SPECS/mesa.spec


diff ~/rpmbuild/SPECS/mesa.spec.bak ~/rpmbuild/SPECS/mesa.spec --context

cd ~/rpmbuild/
rpmbuild -bb ~/rpmbuild/SPECS/mesa.spec


ls ~/rpmbuild/RPMS/x86_64
