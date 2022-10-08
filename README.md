This repo is used to store the source code of the build script used on Fedora COPR to auto-rebuild mesa fedora packages, modified to include additional codecs

The builds occur here: https://copr.fedorainfracloud.org/coprs/carl3830/mesa-fedora-with-codecs/

[![Copr build status](https://copr.fedorainfracloud.org/coprs/carl3830/mesa-fedora-with-codecs/package/mesa/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/carl3830/mesa-fedora-with-codecs/package/mesa/)

### Install mesa with codecs from repo:

```
# enable the repo
sudo dnf copr enable carl3830/mesa-fedora-with-codecs

# set the priority of the repo to 10 so the repo packages of the same name take precedence
sudo dnf config-manager --save --setopt="copr:copr.fedorainfracloud.org:carl3830:mesa-fedora-with-codecs.priority=10"

# run dnf distrosync to install the repo versions of mesa (one time only, they will auto update moving forward)
sudo dnf distrosync
```

### Confirm vaapi is functional with 'vainfo':
```
# install package that provides 'vainfo'
sudo dnf install libva-utils

# run vainfo, check the codec support listed matches what your hardware can handle:
vainfo
```
### Setup Firefox to be able to use va-api hardware video decode for all codecs:
```
# Enable the rpm fusion 'free' repo to get access to needed codec lib files not provided by fedora:
# This is most likley already enabled on your system:
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Optionally install non-free as well:
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update --refresh

# install needed codecs from rpm fusion free repo:
sudo dnf install ffmpeg-libs

# to confirm va-api is working, launch firefox from this command line to see va-api and decode logging:
MOZ_LOG="PlatformDecoderModule:5" firefox

# go play a video of each codec listed in vainfo in firefox
# you should see log output in the terminal indicating VA-API usage. 
# All codecs your hardware supports should now be able to be used by firefox in hardware decode mode.
```

### Remove the repo, and revert to distro provided mesa packages:
```
sudo dnf copr disable carl3830/mesa-fedora-with-codecs

sudo dnf distrosync
```
