[![Build Status](https://travis-ci.org/joenio/holodev.svg?branch=master)](https://travis-ci.org/joenio/holodev)

# holodev

`holodev` maintains a [UNIX][unix] (Do One Thing and Do It Well) and [GNU][gnu]
(free as in freedom) philosophies.

## A holodeck for software development

A tool to facilitate the creation of Linux Containers for developing Debian systems

The name `holodev` is a reference to the Holodeck from Star Trek:

* http://en.wikipedia.org/wiki/Holodeck

Supported GNU/Linux distributions:

| **Distro**          | **holodev 0.9** | **holodev 1.0** | **holodev 1.1** |
| ------------------- | --------------- | --------------- | --------------- |
| Debian Squeezy      | not supported   | not supported   | not supported   |
| Debian Wheezy       | not supported   | not supported   | not supported   |
| Debian Jessie       | supported       | supported       |                 |
| Debian Stretch      | not tested      | not tested      | supported       |
| Debian Buster       | supported       | supported       | supported       |
| Ubuntu Precise      | not supported   | not supported   | not supported   |
| Ubuntu Trusty       | supported       | supported       |                 |
| Ubuntu Utopic       | not tested      | not tested      |                 |
| Ubuntu Vivid        | supported       | not tested      |                 |
| Ubuntu Wily         | supported       | not tested      |                 |
| Ubuntu Xenial       | supported       | supported       |                 |
| Archlinux           | supported       | not tested      |                 |
| openSUSE 42.1       | not tested      | supported       |                 |
| openSUSE 42.2       | not tested      | supported       |                 |
| openSUSE 42.3       | not tested      | not supported   | not supported   |
| openSUSE Tumbleweed | supported       | supported       |                 |
| Fedora 24           | supported       | supported       |                 |
| Fedora 25           | supported       | supported       |                 |
| Fedora 26           | not tested      | supported       |                 |
| Fedora 27           | not tested      | supported       |                 |

## sudo

Unfortunately, support for "unprivileged containers" in Debian Jessie is not mature enough, then `holodev` needs` sudo` to create and run "privileged containers".

## Installing in Debian

Add the following repository to the sources.list:

    deb http://debian.joenio.me unstable/

Download the key from the Debian repo:

    # wget -O - http://debian.joenio.me/signing.asc | apt-key add -

Install:

    # apt-get update
    # apt-get install holodev

## Installing in OpenSUSE


### Development release
For development releases, you'll need to add the `devel:tools` equivalent to your distro version:

#### Tumbleweed
    # zypper ar http://download.opensuse.org/repositories/devel:/tools/openSUSE_Tumbleweed/devel:tools.repo

#### Leap
    # zypper ar http://download.opensuse.org/repositories/devel:/tools/openSUSE_Leap_42.1/devel:tools.repo

#### 13.2
    # zypper ar http://download.opensuse.org/repositories/devel:/tools/openSUSE_13.2/devel:tools.repo

#### 13.1
    # zypper ar http://download.opensuse.org/repositories/devel:/tools/openSUSE_13.1/devel:tools.repo

Then update your repo list:

    # zypper ref

And finally install `holodev`:

    # zypper in holodev

### Stable release

`holodev` is part of the default repositories for current OpenSUSE distros (Leap and Tumbleweed), so no additional repo is needed.

Make sure your repos are updated:

    # zypper ref

And install `holodev`:

    # zypper in holodev


## Installing in Archlinux

To install `holodev` on Archlinux it is necessary to have access to the AUR repository, and have any wrapper of pacman that watches AUR. If you are using Archlinux, it is almost safe to assume that you already have AUR and yaourt already configured to use. In any case, if you don't:

To watch AUR, edit the following file:

    # vi /etc/pacman.conf

Then add:

    [archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/$arch

To install `yaourt` follow this [link](https://archlinux.fr/yaourt-en) instructions

Finally, install holodev:

    yaourt -Syy
    yaourt -S holodev

or:

    yaourt -S holodev-git

if you want the bleeding edge version.

## Installing in Fedora

(pending)

## Using

The `holodev` script creates Linux Containers using the current directory plus the `git branch` to compose the container name, it covers the scenario where, for each project (directory), there is a Linux Container, so that it is not necessary to install development dependecies to your system.

For example, in the `noosfero` directory, in the branch `master` it will create a container called `noosfero-master`:

    ~/src/noosfero$ holodev create

The container `noosfero-master` will be created with Debian Jessie (default). If you wish to inform another version of Debian just use the `--release` or `-r`:

    ~/src/noosfero$ holodev create --release jessie

If you do not want to use the branch `git` to compose the container name, use option `--no-branch`:

    ~/src/noosfero$ holodev create --no-branch

This will create a container called `noosfero`.

## Development

`holodev` has a small test suite implemented based on `shunit2`:

* http://github.com/kward/shunit2

To run these tests you need to install `vagrant`,` virtualbox` and run the command `vagrant up`. In some cases you may need to install `Virtualbox-guest-utils` and perform the following:

    dpkg-reconfigure virtualbox-dkms

Use the script `development-setup.sh` (as root) to install development dependencies on your system.

### Running tests

    vagrant up
    make test-vagrant

### Building Debian package

To avoid running tests when building package run:

    DEB_BUILD_OPTIONS=nocheck gbp buildpackage

## Authors

* Joenio Costa <joenio@joenio.me>
* Carlos Coelho <carlospecter@gmail.com>
* Lucas Severo <lucassalves65@gmail.com>

## License

GNU GPLv2+

[unix]: https://en.wikipedia.org/wiki/Unix_philosophy#Do_One_Thing_and_Do_It_Well
[gnu]: https://www.gnu.org/philosophy/
