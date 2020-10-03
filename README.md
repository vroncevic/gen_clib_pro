# Generate C Library Project

**gen_clib_pro** is shell tool for generating C library project.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

The README is used to introduce the modules and provide instructions on
how to install the modules, any machine dependencies it may have and any
other information that should be provided before the modules are installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/gen_clib_pro.svg)](https://github.com/vroncevic/gen_clib_pro/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/gen_clib_pro.svg)](https://github.com/vroncevic/gen_clib_pro/graphs/contributors)

<!-- START doctoc -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and Licence](#copyright-and-licence)
<!-- END doctoc -->

### Installation

Navigate to release [page](https://github.com/vroncevic/gen_clib_pro/releases) download and extract release archive.

To install **gen_clib_pro** type the following:

```
tar xvzf gen_clib_pro-x.y.z.tar.gz
cd gen_clib_pro-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/gen_clib_pro/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/gen_clib_pro/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/gen_clib_pro/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/gen_clib_pro/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/gen_clib_pro/ver.1.0/bin/gen_clib_pro.sh /root/bin/gen_clib_pro

# Setting PATH
export PATH=${PATH}:/root/bin/

# Generating C library project
gen_clib_pro SimpleTest
```

### Dependencies

**gen_clib_pro** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**gen_clib_pro** is based on MOP.

Code structure:
```
.
├── bin/
│   └── gen_clib_pro.sh
├── conf/
│   ├── gen_clib_pro.cfg
│   ├── gen_clib_pro_util.cfg
│   ├── project_set.cfg
│   └── template/
│       ├── authors.template
│       ├── autogen.template
│       ├── c_editorconfig.template
│       ├── changelog.template
│       ├── configure_ac.template
│       ├── copying.template
│       ├── c_source.template
│       ├── h_header.template
│       ├── makefile_am_root.template
│       ├── makefile_am_src.template
│       ├── news.template
│       ├── pc_in.template
│       └── readme.template
└── log/
    └── gen_clib_pro.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/gen_clib_pro/badge/?version=latest)](https://gen_clib_pro.readthedocs.io/projects/gen_clib_pro/en/latest/?badge=latest)

More documentation and info at:
* [https://gen_clib_pro.readthedocs.io/en/latest/](https://gen_clib_pro.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 by [vroncevic.github.io/gen_clib_pro](https://vroncevic.github.io/gen_clib_pro)

**gen_clib_pro** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

