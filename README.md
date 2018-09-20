# i-doit virtual appliance

Pre-configured virtual machines (VM) for i-doit


##  About

[i-doit](https://i-doit.com) is a software application for IT documentation and a CMDB (Configuration Management Database). This application is very useful to collect all your knowledge about the IT infrastructure you are dealing with. i-doit is a Web application and [has an exhausting API](https://kb.i-doit.com/pages/viewpage.action?pageId=37355644) which is very useful to automate your infrastructure.

Our goal is to provide the best experience with i-doit right from the beginning. Just download, import and start our virtual appliance in your virtualization cluster (or even on your laptop). Then you have:

-   A production-ready installation of i-doit
-   A stable operating system system in the background
-   …which is highly performant, reliable, reasonable, secure, and up-to-date


##  Supported platforms

At the moment, these virtualization platforms are supported (in alphabetical order):

-   Microsoft Hyper-V incl. installed Linux Integration Services
-   Oracle VirtualBox
-   VMware ESXi/Workstation/Player

If you're interested in other platforms, feel free to [raise an issue](https://github.com/bheisig/i-doit-appliance/issues).


##  Features

These are the highlights why to use the i-doit virtual appliance in a production environment:

-   Operating system is the latest stable version of [Debian GNU/Linux](https://debian.org/). [It's our recommened OS.](https://kb.i-doit.com/display/en/System+Requirements)
-   [This tool chain](https://github.com/bheisig/i-doit-scripts) is included, so you're ready to start you own CMDB. This includes:
    -   Pre-installed latest version of i-doit pro
    -   Pre-configured LAMP stack (GNU/Linux, Apache Web server, MariaDB and PHP) + memcached
    -   Easy-use of the i-doit CLI
    -   Run important jobs automatically
    -   Backup and restore i-doit
    -   Alter passwords for various users and remove default users
    -   Collect data about i-doit, installed add-ons and your system
    -   Deploy hot fixes
-   Lazy-maintaining on the shell with tons of little helpers for:
    -   Hostname and network interfaces
    -   Locales, timezone and keyboard layout
    -   SMTP for automated e-mails
    -   Running services like Apache Web server, MariaDB, PHP, and memcached
    -   And many more…
-   Stay up-to-date with…
    -   Unattended updates of distribution packages
    -   NTP for date and time
-   Some important pre-configured security features are available:
    -   Switch easily to [HTTPS and HTTP/2](docs/secure-web-server.md)
    -   A [host-based firewall](docs/firewall.md) is enabled by default

As there is a new version of i-doit published by us, the virtual appliance will be created from scratch for every supported platform. We use reproducible builds which gives us (and you) an predictable and robust build environment. Release cycles are shorter because build jobs are automated. But before releasing them each build will be heavily penetrated by automated tests.


##  Download

Now you like to try out the virtual appliance for yourself? Currently, there is only [an older version available for i-doit pro](https://www.i-doit.com/en/trial-version/). We will publish pre-built releases as soon as possible.


##  Getting started

After downloading the zip file suitable for your virtualization environment extract it. It contains all files needed to import. The import process depends on you virtualization environment and is not part of this documentation.

After importing start the virtual machine. While booting, the VM tries to receive an IPv4 address via DHCP. The current IP address will be shown on the login screen of your VM. If everything works i-doit will be available within your network via HTTP. Type this URL into your Web browser:

~~~
http://<IP address>/
~~~

Login with username `admin` and password `admin`. One of the first things you see will be a warning that your i-doit is not licensed yet. Logout first then go to i-doit's Admin Center:

~~~
http://<IP address>/admin/
~~~

Login with username `admin` and password `admin`. Click on `Licenses` and import your license file provided by the i-doit team.

System configuration is almost done. On every login via SSH an dialog menu opens which provides many, many tools to maintain i-doit, the operating system and all services running on it. For example, **you should change all default passwords**:

1.  Login via SSH with username `idoit` and password `idoit`
2.  As the dialog menu opens go to `Configuration`, then `Change passwords`
3.  Follow the steps

Now go back to i-doit and start working on your CMDB. :-)


##  Default accounts

| Account               | Username      | Password      |
| --------------------- | ------------- | ------------- |
| GNU/Linux incl. SSH   | `idoit`       | `idoit`       |
| GNU/Linux excl. SSH   | `root`        | –             |
| i-doit                | `admin`       | `admin`       |
| i-doit                | `controller`  | `controller`  |
| i-doit Admin Center   | `controller`  | `controller`  |
| MariaDB super user    | `root`        | `root`        |
| MariaDB               | `idoit`       | `idoit`       |


##  Resources

We recommend to check out these resources:

-   [i-doit Website](https://i-doit.com/)
-   [i-doit Knowledge Base](https://kb.i-doit.com/)
-   [i-doit Community forums](https://community.i-doit.com/)
-   [i-doit Help Center](https://help.i-doit.com/)
-   [i-doit customer portal](https://login.i-doit.com) for updates, add-ons and more
-   [i-doit scripts](https://github.com/bheisig/i-doit-scripts) (as mentioned before these scripts are very helpful to maintain i-doit)


##  Contribute & support

[Contributors are welcome!](CONTRIBUTING.md) Report issues to [our issue tracker](https://github.com/bheisig/i-doit-appliance/issues). For professional support, refer to the [i-doit Help Center](https://help.i-doit.com/).


##  Copyright & license

Copyright (C) 2018 [synetics GmbH](https://i-doit.com/)

Licensed under the [GNU Affero GPL version 3 or later (AGPLv3+)](https://gnu.org/licenses/agpl.html). This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
