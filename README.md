# i-doit virtual appliance

Pre-configured virtual machines (VM) for i-doit


##  About

[i-doit](https://i-doit.com) is a software application for IT documentation and a CMDB (Configuration Management Database). This application is very useful to collect all your knowledge about the IT infrastructure you are dealing with. i-doit is a Web application and [has an exhausting API](https://kb.i-doit.com/pages/viewpage.action?pageId=37355644) which is very useful to automate your infrastructure.


##  Supported platforms

At the moment, these virtualization platforms are supported:

-   Oracle VirtualBox
-   VMware ESXi/Workstation/Player

Next platform on this list will be Microsoft Hyper-V. If you're interested in other platforms, feel free to create an [issue](https://github.com/bheisig/i-doit-appliance/issues).


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


##  Download

Now you like to try out the virtual appliance for yourself? Currently, there is only [an older version available for i-doit pro](https://www.i-doit.com/en/trial-version/). We will publish pre-built releases as soon as possible.


##  Contribute & support

[Contributors are welcomed!](CONTRIBUTING.md) Report any issues to [our issue tracker](https://github.com/bheisig/i-doit-appliance/issues).


##  Copyright & license

Copyright (C) 2018 [synetics GmbH](https://i-doit.com/)

Licensed under the [GNU Affero GPL version 3 or later (AGPLv3+)](https://gnu.org/licenses/agpl.html). This is free software: you are free to change and redistribute it. There is NO WARRANTY, to the extent permitted by law.
