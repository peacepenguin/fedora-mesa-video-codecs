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

# run vainfo, check for codec support
vainfo
```
Check Firefox is able to use va-api:
```
# Everything works by default on Fedora 36+ with Wayland and Gnome. Should work in kde/plasma too.

# to confirm va-api is working, launch firefox from this command line:
# set an env variable to log decoder activity in firefox:
MOZ_LOG="PlatformDecoderModule:5"

# then launch firefox from the same command line session:
firefox

# go play a video in firefox, you should see log out put in the terminal like below which indicates successful use of VA-API by firefox:

libva info: VA-API version 1.15.0
libva info: Trying to open /usr/lib64/dri/radeonsi_drv_video.so
libva info: Found init function __vaDriverInit_1_15
libva info: va_openDriver() returns 0

```

