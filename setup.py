#!/usr/bin/env python
# encoding: utf-8
# vi: set ft=python sts=4 ts=4 sw=4 et:

######################################################################
#
#   See COPYING file distributed along with the psignifit package for
#   the copyright and license terms
#
######################################################################

""" setup.py for Psignifit 3.x """

from distutils.core import setup, Extension

# metadata definitions
name = "pypsignifit"
version = "3.0beta"
author = "Ingo Fründ, Valentin Haenel"
author_email = "psignifit-users@lists.sourceforge.net"
description = "Statistical inference for psychometric functions"
url= "http://sourceforge.net/projects/psignifit/"
license = "MIT"
packages = ["pypsignifit", "swignifit"]

# swignifit interface
swignifit_sources = ["swignifit/swignifit_raw.cxx"]
swignifit = Extension('swignifit._swignifit_raw',
        sources = swignifit_sources,
        library_dirs=['src/build'],
        libraries=['psipp'],
        include_dirs=["src"])
ext_modules = [swignifit]

if __name__ == "__main__":
    setup(name = name,
        version = version,
        author = author,
        author_email = author_email,
        description = description,
        url = url,
        license = license,
        packages = packages,
        ext_modules = ext_modules)
