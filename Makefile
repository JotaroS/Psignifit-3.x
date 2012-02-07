# vim: set fdm=marker:
######################################################################
#
#   See COPYING file distributed along with the psignifit package for
#   the copyright and license terms
#
######################################################################

# The main Psignifit 3.x Makefile

#################### VARIABLE DEFINITIONS ################### {{{

SHELL=/bin/bash
CLI_INSTALL=$(DESTDIR)/usr/bin
SPHINX_DOCOUT=doc-html
EPYDOC_DCOOUT=api
PSIPP_DOCOUT=psipp-api
PSIPP_SRC=src
LIBRARY_PATH=$(DESTDIR)/usr/lib/
LD_LIBRARY_PATH=src/build
PYTHON=python
CLI_SRC=cli
TODAY=`date +%d-%m-%G`
LONGTODAY=`date +%G%m%d`
RELEASE_TAG=release/3.0_beta.$(LONGTODAY).1
FILENAME_PREFIX=3.0_beta.$(LONGTODAY).1
ARCHIVE_PREFIX=psignifit_${FILENAME_PREFIX}/
TAR_FILE=psignifit_${FILENAME_PREFIX}.tar
ZIP_FILE=psignifit_${FILENAME_PREFIX}.zip
GIT_DESCRIPTION=`git describe --tags`
CLI_VERSION_HEADER=cli/cli_version.h
MPSIGNIFIT_VERSION=mpsignifit/psignifit_version.m
PYPSIGNIFIT_VERSION=pypsignifit/__version__.py
.PHONY : swignifit ipython psipp-doc

#}}}

#################### GROUPING FILES ################### {{{

PYTHONFILES=$(addprefix pypsignifit/, __init__.py\
	psignidata.py\
	psignierrors.py\
	psigniplot.py\
	psigobservers.py\
	pygibbsit.py)
CFILES_LIB=$(addprefix src/, bootstrap.cc\
	core.cc\
	data.cc\
	linalg.cc\
	mclist.cc\
	mcmc.cc\
	optimizer.cc\
	psychometric.cc\
	rng.cc\
	sigmoid.cc\
	special.cc\
	getstart.cc )
HFILES_LIB=$(addprefix src/, bootstrap.h\
	core.h\
	data.h\
	errors.h\
	linalg.h\
	mclist.h\
	mcmc.h\
	optimizer.h\
	prior.h\
	psychometric.h\
	rng.h\
	sigmoid.h\
	special.h\
	psipp.h\
	getstart.h)
SWIGNIFIT_INTERFACE=swignifit/swignifit_raw.i
SWIGNIFIT_AUTOGENERATED=$(addprefix swignifit/, swignifit_raw.py swignifit_raw.cxx)
SWIGNIFIT_HANDWRITTEN=$(addprefix swignifit/, interface_methods.py utility.py)
DOCFILES=$(addprefix doc-src/, \
		ADDITIONALPLOTSBOOTSTRAP.rst \
		INSTALL_WINDOWS.rst BAYESINTRO.rst \
		CONTRIBUTING.rst \
		PSYCHOMETRICFUNCTIONS.rst \
		DESIGN.rst \
		QUICKSTART.rst \
		DIFFERENCES.rst \
		swig-api.rst \
		index.rst \
		TODO.rst \
		INFLUENTIAL.rst \
		TUTORIAL_BAYES.rst \
		INSTALL_LINUX.rst \
		TUTORIAL_BOOTSTRAP.rst \
		INSTALL_MAC.rst \
		WELCOME.rst \
		INSTALL_MATLAB.rst \
		*.png )
EPYDOC_TARGET=swignifit pypsignifit

# }}}

#################### MAIN DEFINITIONS ################### {{{

build: python-build

install: python-install psipp-install

doc: python-doc psipp-doc

clean: clean-python-doc clean-python psipp-clean cli-clean mpsignifit-clean

test: swignifit-test psipp-test

# }}}

#################### PYTHON DEFINITIONS ################### {{{

python-install: | psipp-build python-version swig
	if [ -n "$(DESTDIR)" ] ; then \
		$(PYTHON) setup.py install --home=$(DESTDIR);\
	else \
		$(PYTHON) setup.py install;\
	fi

python-build: | psipp-build swignifit python-version

clean-python: swignifit-clean
	-rm -rv build
	-rm pypsignifit/*.pyc
	-rm $(PYPSIGNIFIT_VERSION)
	# when building with the windows_setup.py, a setup.pyc file is created
	-rm setup.pyc

python-doc: $(DOCFILES) $(PYTHONFILES) python-build
	mkdir -p $(SPHINX_DOCOUT)/$(EPYDOC_DCOOUT)
	# epydoc -o $(SPHINX_DOCOUT)/$(EPYDOC_DCOOUT) $(EPYDOC_TARGET)
	PYTHONPATH=.:doc-src LD_LIBRARY_PATH=src/build/ sphinx-build doc-src $(SPHINX_DOCOUT)

clean-python-doc:
	-rm -rv $(SPHINX_DOCOUT)

ipython: swignifit
	ipython

python-version:
	if git rev-parse &> /dev/null ; then \
		echo "version = '"$(GIT_DESCRIPTION)"'" > $(PYPSIGNIFIT_VERSION); \
	fi

# }}}

#################### PSIPP COMMANDS ################### {{{

psipp-build:
	cd $(PSIPP_SRC) && $(MAKE)

psipp-install: psipp-build
	if ! [ -d $(LIBRARY_PATH) ] ; then\
		mkdir -p $(LIBRARY_PATH);\
	fi
	cp $(PSIPP_SRC)/build/libpsipp.so $(LIBRARY_PATH)/

psipp-doc:
	doxygen

psipp-clean:
	cd $(PSIPP_SRC) && $(MAKE) clean
	-rm -rv $(SPHINX_DOCOUT)/$(PSIPP_DOCOUT)

psipp-uninstall:
	rm $(LIBRARY_PATH)/libpsipp.so

psipp-test:
	cd $(PSIPP_SRC) && $(MAKE) test

# }}}

################### CLI COMMANDS ###################### {{{

cli-install:  cli-version cli-build psipp-install
	if [ -d $(CLI_INSTALL) ]; then \
		echo $(CLI_INSTALL) " exists adding files"; \
	else \
		mkdir $(CLI_INSTALL); \
		echo ""; echo ""; echo ""; \
		echo "WARNING: I had to create " $(CLI_INSTALL) "you will most probably have to add it to your PATH"; \
		echo ""; echo ""; echo ""; \
	fi
	cd $(CLI_SRC) &&\
	cp psignifit-mcmc psignifit-diagnostics psignifit-bootstrap psignifit-mapestimate $(CLI_INSTALL)

cli-build: cli-version psipp-build
	cd $(CLI_SRC) && $(MAKE)

cli-clean:
	cd $(CLI_SRC) && $(MAKE) clean
	-rm $(CLI_VERSION_HEADER)

cli-test: cli-install
	$(PYTHON) tests/cli_test.py

cli-uninstall:
	rm $(CLI_INSTALL)/psignifit-mcmc
	rm $(CLI_INSTALL)/psignifit-diagnostics
	rm $(CLI_INSTALL)/psignifit-bootstrap
	rm $(CLI_INSTALL)/psignifit-mapestimate

cli-version:
	if git rev-parse &> /dev/null ; then \
		echo "#ifndef CLI_VERSION_H" > $(CLI_VERSION_HEADER) ; \
		echo "#define CLI_VERSION_H" >> $(CLI_VERSION_HEADER) ; \
		echo "#define VERSION \""$(GIT_DESCRIPTION)"\"" >> $(CLI_VERSION_HEADER) ; \
		echo "#endif" >> $(CLI_VERSION_HEADER) ; \
	fi

# }}}

#################### SWIGNIFIT COMMANDS ################### {{{

swig: $(SWIGNIFIT_AUTOGENERATED)

swignifit: $(PYTHONFILES) $(CFILES) $(HFILES) $(SWIGNIFIT_AUTOGENERATED) $(SWIGNIFIT_HANDWRITTEN) setup.py psipp-build
	$(PYTHON) setup.py build_ext -i

$(SWIGNIFIT_AUTOGENERATED): $(SWIGNIFIT_INTERFACE)
	swig -c++ -python -v -Isrc  -o swignifit/swignifit_raw.cxx swignifit/swignifit_raw.i

swignifit-clean:
	-rm -rv $(SWIGNIFIT_AUTOGENERATED)
	-rm -rv swignifit/_swignifit_raw.so
	-rm -rv swignifit/*.pyc

swignifit-test: swignifit-test-raw swignifit-test-interface swignifit-test-utility

swignifit-test-raw: swignifit
	PYTHONPATH=. LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) $(PYTHON) tests/swignifit_raw_test.py

swignifit-test-interface: swignifit
	PYTHONPATH=. LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) $(PYTHON) tests/interface_test.py

swignifit-test-utility: swignifit
	PYTHONPATH=. LD_LIBRARY_PATH=$(LD_LIBRARY_PATH) $(PYTHON) tests/utility_test.py

# }}}

#################### PYPSIGNIFIT COMMANDS ################### {{{

pypsignifit-test:
	PYTHONPATH=. $(PYTHON) pypsignifit/psignidata.py

# }}}


#################### MPSIGNIFIT COMMANDS ################### {{{

mpsignifit-version:
	if git rev-parse &> /dev/null ; then \
		echo "function psignifit_version()" > $(MPSIGNIFIT_VERSION) ; \
		echo "disp('"$(GIT_DESCRIPTION)"')" >> $(MPSIGNIFIT_VERSION) ; \
	fi

mpsignifit-clean:
	-rm $(MPSIGNIFIT_VERSION)

# }}}

#################### DISTRIBUTION COMMANDS ################## {{{

dist-changelog:
	if [[ `git symbolic-ref HEAD` != refs/heads/master ]] ; then \
		echo "FATAL: not on master branch!"; \
		false; \
	fi
	echo $(LONGTODAY) > tmp
	echo >> tmp
	echo "* " >> tmp
	echo >> tmp
	cat changelog >> tmp
	cp changelog changelog_old
	cp tmp changelog
	vi changelog +3
	if diff tmp changelog; then \
		mv changelog_old changelog; \
		echo "FATAL: changelog not modified!"; \
		false; \
	else \
		git commit changelog -m "changelog entry for upload"; \
		git push origin; \
	fi

dist-tar: python-version cli-version mpsignifit-version
	git archive --format=tar --prefix=${ARCHIVE_PREFIX} master > ${TAR_FILE}
	tar --transform "s,^,${ARCHIVE_PREFIX}," -rf ${TAR_FILE} $(PYPSIGNIFIT_VERSION) $(CLI_VERSION_HEADER) $(MPSIGNIFIT_VERSION)
	gzip ${TAR_FILE}

dist-swigged: dist-tar swig
	tar xzf ${TAR_FILE}.gz
	cp swignifit/swignifit_raw.cxx swignifit/swignifit_raw.py ${ARCHIVE_PREFIX}swignifit/
	zip -r ${ZIP_FILE} ${ARCHIVE_PREFIX}
	rm -r ${ARCHIVE_PREFIX}

dist-win: build psignifit-cli.iss cli-version
	if [ -d WindowsInstaller ]; then rm -r WindowsInstaller; fi
	cd cli && make clean && make -f MakefileMinGW
	wine $(HOME)/.wine/drive_c/Program\ Files/Inno\ Setup\ 5/ISCC.exe psignifit-cli.iss
	mv WindowsInstaller/psignifit-cli_3_beta_installer.exe psignifit-cli_3_beta_installer_$(TODAY).exe

dist-win-python-installer: swig
	# Execute on Windows only!
	python windows_setup.py bdist_wininst

dist-upload-doc: python-doc
	# this upload will only work with Ingo's account
	scp -r doc-html/* igordertigor,psignifit@web.sourceforge.net:/home/groups/p/ps/psignifit/htdocs/
	git tag doc-$(LONGTODAY)
	git push origin doc-$(LONGTODAY)
dist-upload-archives: | dist-changelog dist-git-tag-release dist-swigged dist-win
	mkdir psignifit3.0_beta_$(TODAY)
	cp psignifit3.0_beta_$(TODAY).zip psignifit-cli_3_beta_installer_$(TODAY).exe psignifit3.0_beta_$(TODAY)
	if [ -d dist ]; then \
		cp dist/pypsignifit-3.0beta.win32-py2.6.exe psignifit3.0_beta_$(TODAY)/psignifit3.0_beta_$(TODAY)_win32-py2.6.exe; \
	else \
		echo "Installer for Python w32 has not been built; will be omitted in Upload."; \
	fi
	scp -rv psignifit3.0_beta_$(TODAY) igordertigor,psignifit@frs.sourceforge.net:/home/frs/project/p/ps/psignifit/
	#rm -r psignifit3.0_beta_$(TODAY)
	git push origin $(RELEASE_TAG)

dist-git-tag-release:
	if git tag | grep -q $(RELEASE_TAG) ; then \
		echo "A rare case of tagging twice in a day?"; \
		echo "The tag "$(RELEASE_TAG)" exists already."; \
		echo "Currently we do not support this"; \
		false; \
	fi
	git tag -s -m "Psignifit3.x $(RELEASE_TAG)"  $(RELEASE_TAG)

# }}}
