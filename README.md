This repo is used to store the source code of the build script used on Fedora COPR to auto-rebuild mesa fedora packages, modified to include codecs.

The builds occur here: https://copr.fedorainfracloud.org/coprs/carl3830/mesa-fedora-with-codecs/

[![Copr build status](https://copr.fedorainfracloud.org/coprs/carl3830/mesa-fedora-with-codecs/package/mesa/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/carl3830/mesa-fedora-with-codecs/package/mesa/)

To get the rebuilt mesa packages, set up the copr repo, then set the repo priority to be higher than the default repos. Then run dnf distrosync to switch to the repo versions of the mesa packages.

```
# enable the repo
sudo dnf copr enable carl3830/mesa-fedora-with-codecs

# set the priority of the repo to 10 so the repo packages of the same name take precedence
sudo dnf config-manager --save --setopt="copr:copr.fedorainfracloud.org:carl3830:mesa-fedora-with-codecs.priority=10"

# run dnf distrosync to install the repo versions of mesa (one time only, they will auto update moving forward)
sudo dnf distrosync

```


Remove the repo, and revert to distro provided mesa packages:
```
sudo dnf copr disable carl3830/mesa-fedora-with-codecs

sudo dnf distrosync

```

Confirm vaapi is working with 'vainfo'.
```
# install package that provides 'vainfo'
sudo dnf install libva-utils

# run vainfo, check the codec support:
vainfo
```
Enable and confirm Firefox is able to use va-api hardware video decode on fedora:
```
# Enable the rpm fusion 'free' repo to get access to needed codec lib files:
# This is most likley already enabled on your system:
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# Optionally install non-free as well:
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update --refresh

# install needed codecs from rpm fusion free repo:
sudo dnf install ffmpeg-libs

# to confirm va-api is working, launch firefox from this command line to see va-api and decode logging:
MOZ_LOG="PlatformDecoderModule:5" firefox

# go play a video in firefox, you should see log out put in the terminal for VA-API usage when the video start playing.

# optionally install the firefox extension 'h264ify' so you can force avc1 codec use on youtube to test hardware decode. 
# Under youtube 'stats for nerds' you should see 'avc1' to indicate h264 usage.

```

