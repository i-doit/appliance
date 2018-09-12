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


##  Setup a development environment

If you like to contribute source code, documentation snippets, self-explaining examples or other useful bits, fork this repository, setup the environment and make a pull request.

~~~ {.bash}
git clone https://github.com/bheisig/i-doit-appliance.git
~~~

If you have a GitHub account create a fork first and then clone the repository.

After that, change to your cloned repository and do your stuff. Do not forget to commit your changes. When you are done consider to make a pull requests.

Notice, that any of your contributions merged into this repository will be [licensed under the AGPLv3](LICENSE).


##  Requirements

Developer and build environments must meet at least these requirements:

*   [Packer](https://www.packer.io/)
*   Virtualization support enabled for your hardware, especially your CPU

These dependencies are suggested:

*   [Git](https://git-scm.com/)
*   [ShellCheck](https://www.shellcheck.net/)
*   make
*   zip

Depending on which OS you are and which virtualization platform you want to use the requirements may differ. This setup has been tested:

*   Host system: Ubuntu GNU/Linux
*   >= 8 GByte of free RAM
*   >= 10 GByte of free space
*   Desktop environment (VMware requires a GUI)
*   VirtualBox
*   [VMware Workstation Player 14](https://my.vmware.com/de/web/vmware/free#desktop_end_user_computing/vmware_workstation_player/14_0|PLAYER-1411|product_downloads)
*   [VIX API libraries](https://www.vmware.com/support/developer/vix-api/)
*   quemu-utils

Hyper-V is only available on a Windows host. This Hyper-V setup has been tested:

*   Host system: Microsoft Windows 10
*   >= 4 GByte of free RAM
*   >= 10 GByte of free space
*   Hyper-V (of course)
*   Your user needs to added to the "Hyper-V Administrators" group


##  Build virtual appliances

The virtual appliances for VirtualBox and VMware are built on a GNU/Linux host. The one for Hyper-V on a Windows host.


### VirtualBox/VMware

On a GNU/Linux host use your terminal. Change to the project directory and execute the needed make rule:

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


##  Make rules

This project comes with some useful make rules:

| Command               | Description                                   |
| --------------------- | --------------------------------------------- |
| `make build`          | Build virtual appliance                       |
| `make dist`           | Create distribution packages                  |
| `make clean`          | Clean up project directory                    |
| `make shellcheck`     | Validate shell scripts                        |
| `make test`           | Test your environment                         |


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
│   ├── hyper-v.json                # Packer configuration file for Hyper-V
│   ├── packer.json                 # Packer configuration file for VirtualBox and VMware
│   └── prepare-os                  # Automagically prepare OS
├── packer_cache                    # Cache for pre-downloded ISO files
│   └── *.iso
└── README.md
~~~
