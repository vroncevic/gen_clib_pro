GEN_CLIB_PRO
-------------

.. toctree::
 :hidden:

 self

**gen_clib_pro** is shell tool for generating C library project.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/gen_clib_pro.svg
   :target: https://github.com/vroncevic/gen_clib_pro/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/gen_clib_pro.svg
   :target: https://github.com/vroncevic/gen_clib_pro/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/gen_clib_pro/badge/?version=latest
   :target: https://gen_clib_pro.readthedocs.io/projects/gen_clib_pro/en/latest/?badge=latest

INSTALLATION
-------------

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/gen_clib_pro/releases

To install **gen_clib_pro** type the following:

.. code-block:: bash

   tar xvzf gen_clib_pro-x.y.z.tar.gz
   cd gen_clib_pro-x.y.z
   cp -R ~/sh_tool/bin/   /root/scripts/gen_clib_pro/ver.1.0/
   cp -R ~/sh_tool/conf/  /root/scripts/gen_clib_pro/ver.1.0/
   cp -R ~/sh_tool/log/   /root/scripts/gen_clib_pro/ver.1.0/

DEPENDENCIES
-------------

**gen_clib_pro** requires next modules and libraries:
    sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

SHELL TOOL STRUCTURE
---------------------

**gen_clib_pro** is based on MOP.

Code structure:

.. code-block:: bash

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

COPYRIGHT AND LICENCE
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 by `vroncevic.github.io/gen_clib_pro <https://vroncevic.github.io/gen_clib_pro>`_

This tool is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

