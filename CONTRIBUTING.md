# Contributors welcome!

Thank you very much for your interest in this project! There are plenty of ways you can support us. :-)

## Code of Conduct

We like you to read and follow our [code of conduct](CODE_OF_CONDUCT.md) before contributing. Thank you.

## Use it

The best and (probably) easiest way is to use one of the pre-built virtual appliance. It would be very nice to share your thoughts with us. We love to hear from you.

If you have questions how to use it properly read the [documentation](README.md) carefully.

## Report bugs

If you find something strange please report it to [our issue tracker](https://github.com/bheisig/i-doit-appliance/issues).

## Make a wish

Of course, there are some features in the pipeline. However, if you have good ideas how to improve this application please let us know! Write a feature request [in our issue tracker](https://github.com/bheisig/i-doit-appliance/issues).

## Setup a build/development environment

If you like to build your own virtual appliance, contribute source code, documentation snippets, self-explaining examples or other useful bits, fork this repository, setup the environment and make a pull request.

### Hardware requirements

Make sure your system has the power to run several virtual machines at once. You need:

-   >= 2 CPU cores with support for virtualization instructions
-   >= 8 GByte of free RAM
-   >= 10 GByte of free space

You may run your host as a virtual machine with activated nested paging but physical hardware probably has a better performance.

### Operating system requirements

We recommend to use a GNU/Linux operating system in 64bit flavor. For a Hyper-V compatible virtual appliance you need a Windows host (see below). We use a physical host with an installed **Ubuntu Linux 18.04 LTS "bionic" 64bit**. All further instructions are suitable for Debian GNU/Linux based operating systems.

### Install first needed distribution packages

First, we need `git` and `make`:

~~~ {.bash}
sudo apt-get update
sudo apt-get install -y --no-install-recommends git make
~~~

### Clone repository

Next, we clone the repository and change to the new directory:

~~~ {.bash}
git clone https://github.com/bheisig/i-doit-appliance.git
cd i-doit-appliance
~~~

### Install environment

Our build environment is based on [Packer](https://packer.io). To build the virtual appliance the also need Oracle [VirtualBox](https://www.virtualbox.org/) and [VMware Workstation Player](https://vmware.com/). Testing mainly depends on [ShellCheck](https://shellcheck.net/) and [InSpec](https://inspec.io/).

For a one-liner-to-install-them-all use this:

~~~ {.bash}
sudo make install
~~~

### Verify your host

Make sure all dependencies are installed and configured properly:

~~~ {.bash}
make test
~~~

## Build virtual appliances

The virtual appliances for VirtualBox and VMware are built on a GNU/Linux host, the one for Hyper-V on a Windows host.

### VirtualBox/VMware

Change to the project directory and execute the make rule to parallel build all flavors:

~~~ {.bash}
cd /path/to/i-doit-appliance
make build
~~~

See it in action:

[![asciicast](https://asciinema.org/a/14.png)](https://asciinema.org/a/BWQW0oJljW4w9xqMr41lV6ixt?autoplay=1&speed=10)

## Create distribution packages

After the build process there is one little step before publishing the virtual appliance:

~~~ {.bash}
make dist
~~~

### Hyper-V

Hyper-V is only available on a Windows host. This Hyper-V setup has been tested:

-   Microsoft Windows Server 2016
-   >= 2 CPU cores
-   >= 4 GByte of free RAM
-   >= 10 GByte of free space
-   Hyper-V (of course)
-   Your user needs to added to the "Hyper-V Administrators" group
-   Download the latest packer.exe and copy it into the project directory

On a Windows host open a command prompt with administrator rights. Change to the project directory and execute the bat file:

~~~
cd C:\path\to\i-doit-appliance
./hyper-v.bat
~~~

## Pull requests

If you have a GitHub account create a fork and then clone the repository. After that, change to your cloned repository and do your stuff. Do not forget to commit your changes. When you are done consider to make a pull requests.

Notice, that any of your contributions merged into this repository will be [licensed under the AGPLv3](LICENSE).

## Test virtual appliance

On a GNU/Linux host you should test whether the virtual appliance has been built properly. Therefore, you find some shell scripts under `tests/`. These tests can only be performed while virtual appliance has been booted.

## Update your build/development environment

Your environment should be up-to-date before building:

~~~ {.bash}
cd i-doit-appliance/
git pull
sudo make update
make test
~~~

## Make rules

This project comes with some useful make rules:

| Command                       | Description                                   | Requires `root`   |
| ----------------------------- | --------------------------------------------- | ----------------- |
| `make`                        | Run make rule `build`                         | Yes               |
| `make build`                  | Build virtual appliances in all flavors       | No                |
| `make build-virtualbox`       | Build virtual appliance for VirtualBox        | No                |
| `make build-vmware`           | Build virtual appliance for VMware            | No                |
| `make clean`                  | Clean up project directory                    | No                |
| `make dist`                   | Create distribution packages in all flavors   | No                |
| `make dist-hyper-v`           | Create distribution package for Hyper-V       | No                |
| `make dist-virtualbox`        | Create distribution package for VirtualBox    | No                |
| `make dist-vmware`            | Create distribution package for VMware        | No                |
| `make install`                | Setup a build/development environment         | Yes               |
| `make install-inspec`         | Only install InSpec                           | No                |
| `make install-node-moules`    | Only install Node modules                     | Yes               |
| `make install-packages`       | Only install distribution packages            | Yes               |
| `make install-packer`         | Only install Packer                           | Yes               |
| `make install-shellcheck`     | Only install ShellCheck                       | Yes               |
| `make install-virtualbox`     | Only install VirtualBox                       | Yes               |
| `make install-vmware`         | Only install VMware Workstation Player        | Yes               |
| `make list-binaries`          | List paths to needed binaries                 | No                |
| `make lint-json`              | Validate JSON files                           | No                |
| `make lint-markdown`          | Validate markdown files                       | No                |
| `make lint-shell`             | Validate shell scripts                        | No                |
| `make lint-yaml`              | Validate YAML files                           | No                |
| `make test`                   | Test your environment                         | No                |
| `make update`                 | Update build/development environment          | Yes               |

## Repository

~~~ {.bash}
.
├── bin                             # Will be copied to /usr/local/bin/
│   ├── […]
├── builds                          # Pre-built virtual appliances
│   └── […]
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── deploy                          # Automagically deploy i-doit on virtual machine
├── dist                            # Distribution files of virtual appliances
│   └── *.zip
├── docs                            # Documentation
│   └── […]
├── dotfiles                        # Dot files for ~
│   ├── bash_aliases
│   └── bashrc
├── .editorconfig
├── etc                             # Will be copied to /etc/
│   ├── apache2
│   │   └── sites-available
│   │       └── i-doit-secure.conf
│   ├── appliance_version
│   ├── issue-standard
│   └── network
│       └── if-up.d
│           └── create-issue-files
├── .gitattributes
├── .gitignore
├── http
│   ├── preseed_stretch_hyper-v.cfg # Used for unattended OS installation on Hyper-V
│   └── preseed_stretch.cfg         # Used for unattended OS installation
├── hyper-v.bat                     # Build virtual appliance for Hyper-V
├── inspec_cache                    # Cached InSpec compliance tests
├── LICENSE
├── Makefile                        # Make rules
├── packer_cache                    # Cache for pre-downloded ISO files
│   └── *.iso
├── packer.json                     # Packer configuration file
├── README.md
└── tests                           # Tests
    ├── htaccess                    # Test Apache configuration settings
    └── inspec                      # Run InSpec compliance tests
~~~
