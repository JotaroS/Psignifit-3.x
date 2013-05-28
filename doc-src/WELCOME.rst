========================
Welcome to Psignifit 3.0
========================

Psignifit is a toolbox that allows the user to fit psychometric functions and to test
hypotheses about psychometric data. Compared to the "classical" version of Psignifit,
the new package comes with a number of **additional features**:
    * full Bayesian treatment of psychometric functions including Bayesian model selection and goodness of fit assessment
    * identification of influential observations
    * detection of outliers (potentially to be excluded)
    * new philosophy of defining the shape of the psychometric function allowing for considerably more flexibility in specifiing psychometric function models.

The preferred interface for Psignifit 3.0 is now `Python <http://www.python.org/>`_, but Matlab is also supported. In contrast to
Matlab, Python is a complete programming language that supports virtually all features you
might wish for. Python allows you to perform numerical computations as flexible and fast as
in Matlab. In addition, Python provides features like object oriented programming and simple creation of graphical user interfaces. Python is easy to learn: even users with no prior programming experience can master Python within weeks.
Finally Python is free to use because of its OSI-approved open source license.

However, even though Python is similar to **Matlab**, it is not the same. Therefore, we also plan
to provide a Matlab version of Psignifit 3.0 with the first official release. However, we will
not guarantee support for this toolbox in future releases and we encourage users to use the
Python version as this will be up to date.

We also noted that a growing number of statistical toolboxes are designed for the statistics
environment *R* and there might be users that are interested in using a R version of Psignifit.
Similar to the Matlab interface, we provide a basic R version of Psignifit 3.0. Again, we do not
guarantee support for this R library. A very rudimentary R library can be found in the folder 'rpsignifit'. Be warned that this is work in progress.


We would be glad to find developers that are interested in supporting these non-Python interfaces
to the Psignifit engine.

.. raw :: html

    <div class="admonition-see-also admonition seealso">
    <p class="first admonition-title">Important</p>
    <p class="last">
    Psignifit3 is beta software. This means that it is still under heavy development. Occasionally
    it might not work as expected. This might have two reasons:
    either, the documentation was ambiguous, or you have discovered a programming error (bug).
    In any case, you would help us a lot if you write an email to our mailing list (see below)
    or <a href="mailto:igordertigor@users.sourceforge.net,valentin-haenel@users.sourceforge.net?subject=[psignifit]">personally to us</a>.
    Typically we can solve your problem within hours.
    </p>
    </div>


****************
Getting in touch
****************

To contact the authors and current maintainers please use:

    psignifit-users@lists.sourceforge.net


This list can be used to ask questions about usage and installation, report
bugs, and request new features. If you use Psignifit on a regular basis we
recommend you `subscribe
<https://lists.sourceforge.net/lists/listinfo/psignifit-users>`_ to this list.

.. note:: Non-member postings are allowed so you do not need to subscribe to the
          list, to post to it. However, we recommend you mention that you are not
          subscribed, so that we don't forget to include you in our reply.

Discussions about development and Psignifit internals happen on:

    psignifit-devel@lists.sourceforge.net

Subscribe `here <https://lists.sourceforge.net/lists/listinfo/psignifit-devel>`_
if you plan to contribute or simply want to follow development.


************************
Authors and Contributors
************************

Authors & Contributors

The Psignifit3 core development team currently consists of:

* Ingo Fründ
* Valentin Haenel

We are very grateful to the following people, who have contributed to Psignifit3:

* Alexander Ecker
* Simon Barthelmé
* Hannah Dold
* Sophie Herbst
* Jeremy Hill
* Marianne Maertens
* Manuel Spitschan
* Felix Wichmann
* Katharina Maria Zeiner
* Tiziano Zito

*****************************************
Conventions used throughout this Document
*****************************************

Commands to be entered into the shell prompt (e.g. ``bash``) are prefixed
with the ``$`` character, for example:

.. code-block:: console

   $ make install

Commands to be entered into the python interpreter (e.g. ``ipython``) will be
prefixed with the ``>>>`` characters, for example:

.. code-block:: pycon

   >>> import pypsignifit

**************
How to install
**************

The following sections detail the installation instructions for the Python
version of **Psignifit (python-psignifit)** and the **Command Line Interface
(cli)**:

* :doc:`INSTALL_LINUX`
* :doc:`INSTALL_MAC`
* :doc:`INSTALL_WINDOWS`

If you wish to use the **Matlab version of Psignifit (mpsignifit)**, *first* follow
the appropriate installation instructions above to install the Command Line
Interface. *And then* see :doc:`INSTALL_MATLAB`. The Command Line Interface *is
required* for the Matlab version of Psignifit.

Installation instructions for the R version of Psignifit (rpsignifit) are going
to follow as soon as this toolboxes is ready for use.

For additional information about the structure of the code, the build system,
version control and an extended list of dependencies  see: :doc:`CONTRIBUTING`.

***********
How to cite
***********

The following reference currently (Jul 2011) provides the most detail on the
implementation of Psignifit3:

Fründ, I, Haenel, NV, Wichmann, FA. *Inference for psychometric functions in the presence of nonstationary behavior.* Journal of Vision 2011

It is available directly from Journal of Vision:
`http://www.journalofvision.org/content/11/6/16
<http://www.journalofvision.org/content/11/6/16>`_

Bibtext entry::

    @Article{FrundJOV2011,
        author = "Fr{\"u}nd, I and Haenel, N V and Wichmann, F A",
        title = {Inference for psychometric functions in the presence of
        nonstationary behavior},
        abstract = {Measuring sensitivity is at the heart of psychophysics.
        Often, sensitivity is derived from estimates of the psychometric
        function. This function relates response probability to stimulus
        intensity. In estimating these response probabilities, most studies
        assume stationary observers: Responses are expected to be dependent only
        on the intensity of a presented stimulus and not on other factors such
        as stimulus sequence, duration of the experiment, or the responses on
        previous trials. Unfortunately, a number of factors such as learning,
        fatigue, or fluctuations in attention and motivation will typically
        result in violations of this assumption. The severity of these
        violations is yet unknown. We use Monte Carlo simulations to show that
        violations of these assumptions can result in underestimation of
        confidence intervals for parameters of the psychometric function. Even
        worse, collecting more trials does not eliminate this misestimation of
        confidence intervals. We present a simple adjustment of the confidence
        intervals that corrects for the underestimation almost independently of
        the number of trials and the particular type of violation.},
        journal = "Journal of Vision",
        year = "2011",
        volume = "11",
        number = "6",
        pages = "",
        month = "May",
        pmid = "21606382",
        url = "http://www.journalofvision.org/content/11/6/16"
        doi = "10.1167/11.6.16"
    }
