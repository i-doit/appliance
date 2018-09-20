#   Contributors welcome!

Thank you very much for your interest in this project! There are plenty of ways you can support us. :-)


##  Code of Conduct

We like you to read and follow our [code of conduct](CODE_OF_CONDUCT.md) before contributing. Thank you.


##  Use it

The best and (probably) easiest way is to use one of the pre-built virtual appliance. It would be very nice to share your thoughts with us. We love to hear from you.

If you have questions how to use it properly read the [documentation](README.md) carefully.


##  Report bugs

If you find something strange please report it to [our issue tracker](https://github.com/bheisig/i-doit-appliance/issues).


##  Make a wish

Of course, there are some features in the pipeline. However, if you have good ideas how to improve this application please let us know! Write a feature request [in our issue tracker](https://github.com/bheisig/i-doit-appliance/issues).


##  Setup a build/development environment

If you like to contribute source code, documentation snippets, self-explaining examples or other useful bits, fork this repository, setup the environment and make a pull request.

### Hardware requirements

Make sure your system has the power to run several virtual machines at once. You need:

*   >= 2 CPU cores with support for virtualization instructions
*   >= 8 GByte of free RAM
*   >= 10 GByte of free space

You may run your host as a virtual machine with activated nested paging but a physical hardware should have a better performance.

### Operating system requirements

We recommend to use a GNU/Linux operating system in 64bit flavor. For a Hyper-V compatible virtual appliance you need a Windows host (see below). We use a physical host with an installed **Ubuntu Linux 18.04 LTS 64bit**. All further instructions are suitable for Debian GNU/Linux based operating systems.

### Install distribution packages

Make sure you have the following distribution packages installed:

~~~
sudo apt install git build-essential shellcheck ruby ruby-dev wget curl lsb-release zip unzip quemu-utils libdigest-sha-perl
~~~

### Install packer

Our build environment is based on [Packer](https://packer.io). On their website you find detailed instructions to install Packer on various operating systems. These commands may be out-dated:

~~~ {.bash}
export PACKER_VERSION="1.3.1"
wget https://releases.hashicorp.com/packer/"$PACKER_VERSION"/packer_"$PACKER_VERSION"_linux_amd64.zip
wget https://releases.hashicorp.com/packer/"$PACKER_VERSION"/packer_"$PACKER_VERSION"_SHA256SUMS
wget https://releases.hashicorp.com/packer/"$PACKER_VERSION"/packer_"$PACKER_VERSION"_SHA256SUMS.sig
curl https://keybase.io/hashicorp/pgp_keys.asc | gpg --import
gpg --verify packer_"$PACKER_VERSION"_SHA256SUMS.sig packer_"$PACKER_VERSION"_SHA256SUMS
shasum -a 256 -c packer_"$PACKER_VERSION"_SHA256SUMS
unzip packer_"$PACKER_VERSION"_linux_amd64.zip
sudo mv packer /usr/local/bin/
rm packer_"$PACKER_VERSION"_linux_amd64.zip packer_"$PACKER_VERSION"_SHA256SUMS packer_"$PACKER_VERSION"_SHA256SUMS.sig
~~~


### Install VirtualBox

To build the appliance for Oracle VirtualBox you need to install it. On their website you find [detailed instructions](https://www.virtualbox.org/wiki/Linux_Downloads). Run these commands as `root`:

~~~ {.bash}
echo "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -c -s) contrib" > /etc/apt/sources.list.d/virtualbox.list
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | apt-key add -
apt-get update
apt-get install virtualbox-5.2
~~~


### Install VMware

If you want to build the virtual appliance for VMware you'll need:

*   [VMware Workstation Player 14](https://my.vmware.com/de/web/vmware/free#desktop_end_user_computing/vmware_workstation_player/14_0|PLAYER-1411|product_downloads)
*   [VIX API libraries](https://www.vmware.com/support/developer/vix-api/)

Please follow the download and installation instructions on their website.

**Notice:** You must have a desktop environment because (VMware requires a GUI)


### Install Hyper-V

Hyper-V is only available on a Windows host. This Hyper-V setup has been tested:

*   Host system: Microsoft Windows 10
*   >= 2 CPU cores
*   >= 4 GByte of free RAM
*   >= 10 GByte of free space
*   Hyper-V (of course)
*   Your user needs to added to the "Hyper-V Administrators" group


##  Install InSpec

We use [InSpec](https://inspec.io/) to perform common and some appliance-specific compliance tests. Installation is done by:

~~~ {.bash}
sudo gem install inspec
~~~


### Clone repository

~~~ {.bash}
git clone https://github.com/bheisig/i-doit-appliance.git
~~~

If you have a GitHub account create a fork first and then clone the repository.

After that, change to your cloned repository and do your stuff. Do not forget to commit your changes. When you are done consider to make a pull requests.

Notice, that any of your contributions merged into this repository will be [licensed under the AGPLv3](LICENSE).


### Verify your host

To make sure you installed and configured all dependencies properly run:

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


### Hyper-V

On a Windows host open a command prompt with administrator rights. Change to the project directory and execute the bat file:

~~~
cd C:\path\to\i-doit-appliance
./hyper-v.bat
~~~


##  Test virtual appliance

On a GNU/Linux host you should test whether the virtual appliance has been built properly. Therefore, you find some shell scripts under `tests/`. These tests can only be performed while virtual appliance has been booted.


##  Make rules

This project comes with some useful make rules:

| Command                   | Description                                   |
| ------------------------- | --------------------------------------------- |
| `make build`              | Build virtual appliances in all flavors       |
| `make build-virtualbox`   | Build virtual appliance for VirtualBox        |
| `make build-vmware`       | Build virtual appliance for VMware            |
| `make clean`              | Clean up project directory                    |
| `make dist`               | Create distribution packages in all flavors   |
| `make dist-virtualbox`    | Create distribution package for VirtualBox    |
| `make dist-vmware`        | Create distribution package for VMware        |
| `make prepare-host`       | Setup a build/development environment         |
| `make shellcheck`         | Validate shell scripts                        |
| `make test`               | Test your environment                         |


##  Repository

~~~ {.bash}
.
├── bin                             # Will be copied to /usr/local/bin/
│   ├── […]
├── builds                          # Pre-built virtual appliances
│   └── […]
├── CHANGELOG.md
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── hyper-v.bat                     # Build virtual appliance for Hyper-V
├── dist                            # Distribution files of virtual appliances
│   └── *.zip
├── docs
│   ├── issue_template.md
│   └── pull_request_template.md
├── dotfiles                        # Dotfiles for ~
│   ├── bash_aliases
│   └── bashrc
├── .editorconfig
├── etc                             # Will be copied to /etc/
│   ├── appliance_version
│   ├── issue-standard
│   └── network
│       └── if-up.d
│           └── create-issue-files
├── .gitattributes
├── .gitignore
├── LICENSE
├── Makefile                        # Make rules
├── packer
│   ├── http
│   │   ├── preseed_stretch_hyper-v.cfg # Used for unattended OS installation on Hyper-V
│   │   └── preseed_stretch.cfg     # Used for unattended OS installation
│   ├── packer.json                 # Packer configuration file
│   └── prepare-os                  # Automagically prepare OS
├── packer_cache                    # Cache for pre-downloded ISO files
│   └── *.iso
├── README.md
└── tests                           # Tests
    ├── checksums                   # Verify builds
    ├── htaccess                    # Test Apache configuration settings
    └── inspec                      # Run InSpec compliance tests
~~~
