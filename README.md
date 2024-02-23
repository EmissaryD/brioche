# Brioche

**Brioche is not supported since ChromeOS r118 as sudo is not possible in crosh shell anymore.**

## Overview

First of all, thanks go to the Crouton maintainers for their work which was actively used when creating this project.

This project consists in providing ChromeOS with an alternative to Crostini and Crouton. It uses the brunch-toolchain as a base which has support for LXC containers. Currently, "debian", "archlinux", "ubuntu", "mint" and "kali" containers variants are available.

Why developing this whereas Crostini and Crouton exist ?
- Crostini uses a VM which makes it slow on some hardware and prevents direct access to devices.
- Crouton and Brioche are very similar, brioche is just a different interpretation of chroots.

Examples of Brioche use cases:
- Playing games in steam, WINE, ... without the Crostini VM performance impact.
- Full access to your devices, native use of ADB for example.
- Running zoom (or another software) if your camera is supported in the linux kernel but not in ChromeOS
- ... you tell me

Does this work on real chromebooks ?
Unfortunately no, it seems some of the needed kernel configs for LXC are only available in the crostini vm kernel and not in the main chromeos one.

**Warning:**
**Brioche runs privileged containers with direct access to everything on your laptop. As such, your containers need to be treated the same way you would treat any linux distro regarding security, notably being careful with what you install on it and keeping it up-to-date, as any exploited vulnerability within the container would provide system wide access to your device.**

## Install instructions

1. Install the brunch-toolchain (refer to https://github.com/sebanc/brunch-toolchain)

2. Download the brioche script from the master branch of this repo and install it:
```
curl -l https://raw.githubusercontent.com/EmissaryD/brioche/main/brioche -o ~/Downloads/brioche
install -Dt /usr/local/bin -m 755 ~/Downloads/brioche
```

Note: To update brioche to a new version, you just need to re-perform step 2. Your existing containers should still work but only newly created ones will benefit from the new features.

## Usage

Usage:
brioche [container name] [app, cmd, create, destroy, desktop, list-desktops, shell, stop] \<extra arguments>
- [app] launches the GUI app with the executable name passed as extra argument (e.g. brioche [container name] app vlc).
- [cmd] launches the shell command specified as extra argument (e.g. brioche [container name] cmd sudo apt install vlc).
- [create] creates the specified LXC container."
- [destroy] deletes the specified LXC container.
- [desktop] launches the desktop specified as extra argument (use [list-desktops] to see which desktops are available) (e.g. brioche [container name] desktop ubuntu).
- [list-desktops] list the desktop sessions currently available in the LXC container (desktop sessions are located in the /usr/share/xsessions directory).
- [shell] opens a console session in the LXC container.
- [stop] stops the specified LXC container.
"To list existing containers, use directly "sudo lxc-ls --fancy"

## Suggestion to create a first container

- Create a container named "mycontainer":
run `brioche mycontainer create`
-> Select "debian"
- Once installation is finished:
run `brioche mycontainer cmd sudo apt install task-gnome-desktop firefox-esr vlc` to install the gnome desktop, firefox and vlc.
- To launch firefox:
run `brioche mycontainer app firefox`
- To launch the desktop:
run `brioche mycontainer desktop gnome`

## Main known issues

- Most distros seem to have issues when using "tasksel" to install a desktop, use the distro's standard package manager instead.
- vscode will only launch if you add the "--verbose" argument (i.e. `brioche mycontainer app code --verbose`)

## Support

Support on Brioche will be limited as it contains the same bugs as the different linux distros it uses. I am counting on the community to help improve/maintain it. Also, the different Linux forums will probably be a great source of information to solve your issues.
