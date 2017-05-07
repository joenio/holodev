# NAME

holodev - tool that makes it easier the creation Linux containers

# SYNOPSIS

    holodev <COMMAND> [OPTIONS]

# DESCRIPTION

A tool to facilitate the creation of GNU/Linux Containers running Debian
system aimed to be used as a development environment.

Features:

- Naming containers is automatic defined, the `holodev` creates Linux Containers (LXC) using the current directory plus
the `git branch` to compose the container name, it covers the scenario where,
for each project (directory), there is a Linux Container, so that it is not
necessary to install development dependecies to your system.

    For example, if I'm working on _Noosfero_ project and I have a clone of the
    sources in the `noosfero` directory, and if I'm on the git branch `master` it
    will create a container called **noosfero-master** when I call `holodev create`:

        ~/src/noosfero$ holodev create

    The container **noosfero-master** will be created with Debian Jessie (default).
    If you wish to inform another version of Debian just use the `--release`
    option:

        ~/src/noosfero$ holodev create --release stretch

    If you do not want to use the _git branch name_ to compose the container name,
    use the option `--no-branch`:

        ~/src/noosfero$ holodev create --no-branch

    This will create a container called just **noosfero**.

- When creating containers the holodev creates LXC configuration file under
`/var/lib/lxc/<CONTAINER_NAME>/config` for each container. See an
example of the `config` file:

        lxc.network.type = veth
        lxc.network.link = virbr0
        lxc.mount = /var/lib/lxc/<CONTAINER_NAME>/fstab
        lxc.aa_allow_incomplete = 1
        lxc.aa_profile = unconfined

- holodev creates a user into container using the same username in use on host
machine.
- The user created into the container by holodev is added to sudo into the
container machine.
- holodev copy some files and directories from host machine into the container, only the files
available on host machine under the home of user running holodev are copied.
    - `~/.gnupg`
    - `~/.gitconfig`
- holodev uses `xinetd` to binds port between host machine and container machine,
by default it uses the `3000` port, but a diferent port can be defined passing
the option `--bind` when starting a container, eg:

        holodev start --bind 4004

# COMMANDS

- restart

    Restart the container associated with the current directory.

- attach

    Connect to the container console, if the container is stopped holodev starts
    then before attach.

- setup

    (pending)

- create

    (pending)

- info

    (pending)

- run

    (pending)

- start

    Executes `lxc-start` in background mode and wait the container up and RUNNING,
    initialize the network service on the container and bind port using xinetd.

- stop

    Unbind xinetd port and stop the container with `lxc-stop` command.

- destroy

    Unbind xinetd port and force remotion of the container with `lxc-destroy`
    command.

- list

    List all containers match the current directory name, is `--all` option
    is passed then directory name is ignored and all LXC containers are listed.

# OPTIONS

- --bind _&lt;port-number>_

    (descrever opcao)

- --no-branch

    (descrever opcao)

- --branch _&lt;git-branch-name>_

    (descrever opcao)

- --release _&lt;debian-release-name>_

    Specify the version of Debian used in new containers (default: jessie), eg
    creating Debian version 8, Stretch:

        holodev create --release stretch

- --dummy

    (descrever opcao)

- --all

    (descrever opcao)

- --arch _&lt;architecture>_

    Set the container architecture, default is the same architecture of host
    machine.

- --version

    Show the version number.

# EXAMPLES

Create fresh container with Debian Jessie:

    holodev create --release jessie

Attach to the console of container and bind the 8080 port:

    holodev attach --bind 8080

# SEE ALSO

[lxc(7)](http://man.he.net/man7/lxc), [lxc-create(1)](http://man.he.net/man1/lxc-create), [git(1)](http://man.he.net/man1/git), [git-branch(1)](http://man.he.net/man1/git-branch)

# LICENSE

GNU GPLv2+

# AUTHOR

See `README.md` file.
