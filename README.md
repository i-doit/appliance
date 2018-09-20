# i-doit virtual appliance

Pre-configured virtual machines (VM) for i-doit


##  About

[i-doit](https://i-doit.com) is a software application for IT documentation and a CMDB (Configuration Management Database). This application is very useful to collect all your knowledge about the IT infrastructure you are dealing with. i-doit is a Web application and [has an exhausting API](https://kb.i-doit.com/pages/viewpage.action?pageId=37355644) which is very useful to automate your infrastructure.


##  Supported platforms

At the moment, these virtualization platforms are supported:

-   Microsoft Hyper-V incl. installed Linux Integration Services
-   Oracle VirtualBox incl. installed Guest Additions
-   VMware ESXi/Workstation/Player

If you're interested in other platforms, feel free to create an [issue](https://github.com/bheisig/i-doit-appliance/issues).


##  Features

-   As there is a new version of i-doit published by us each VM will be created from scratch
-   Operating system is the latest stable version of [Debian GNU/Linux](https://debian.org/). [It's our recommened OS.](https://kb.i-doit.com/display/en/System+Requirements)
-   [This tool chain](https://github.com/bheisig/i-doit-scripts) is included, so you're ready to build you own CMDB. This includes:
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
    -   SMTP
    -   Apache Web server, MariaDB, PHP, memcached
    -   And much more…
-   Stay up-to-date with…
    -   Unattended updates of distribution packages
    -   NTP
-   Some important pre-configured security features are available:
    -   [Host-based firewall](docs/firewall.md)


##  Download

Now you like to try out the virtual appliance for yourself? Currently, there is only [an older version available for i-doit pro](https://www.i-doit.com/en/trial-version/). We will publish pre-built releases as soon as possible.


##  Getting started

After downloading the zip file suitable for your virtualization environment extract it. It contains all files needed to import. The import process depends on you virtualization environment and is not part of this documentation.

After importing start the virtual machine. While booting the VM tries to receive an IPv4 address via DHCP. The current IP address will be shown on the login screen of your VM. If everything works i-doit will be available within your network via HTTP. Type this URL into your Web browser:

~~~
http://<IP address>/
~~~

Login with username `admin` and password `admin`. One of the first things you see will be a warning that your i-doit is not licensed yet. Logout first then go to i-doit's Admin Center:

~~~
http://<IP address>/admin/
~~~

Login with username `admin` and password `admin`. Click on `Licenses` and import your license file provided by the i-doit team.

System configuration is almost done. On every login via SSH an dialog menu opens which provides many, many tools to setup i-doit, the operating system and all services running on it. For example, **you should change all default passwords**:

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
| MariaDB               | `root`        | `root`        |
| MariaDB               | `idoit`       | `idoit`       |


##  Contribute & support

[Contributors are welcomed!](CONTRIBUTING.md) Report any issues to [our issue tracker](https://github.com/bheisig/i-doit-appliance/issues).


##  Copyright & license

Copyright (C) 2018 [synetics GmbH](https://i-doit.com/)

Licensed under the [GNU Affero GPL version 3 or later (AGPLv3+)](https://gnu.org/licenses/agpl.html). This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
