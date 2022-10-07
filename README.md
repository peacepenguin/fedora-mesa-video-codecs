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
Enable Firefox to use VAAPI decode:
```
# In firefox, goto about:config

# Set:

media.ffmpeg.vaapi.enabled                    true
media.ffvpx.enabled                           false  (Disables built in VP8/VP9 software decode)
media.rdd-vpx.enabled                         false  (Disable RDD for ffvpx)
media.navigator.mediadatadecoder_vpx_enabled  true   (enable vaapi for webrtc)
media.rdd-ffmpeg.enabled                      false  (Disable RDD for ffmpeg)
```

