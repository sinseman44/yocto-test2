# Recipe created by recipetool
# This is the basis of a recipe and may need further editing in order to be fully functional.
# (Feel free to remove these comments when editing.)

# WARNING: the following LICENSE and LIC_FILES_CHKSUM values are best guesses - it is
# your responsibility to verify that the values are complete and correct.
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=48f929762847f579de6d30e4ce30f228"

SRC_URI = "git://github.com/sinseman44/yocto-test2.git;protocol=https"

# Modify these as desired
PV = "1.0+git${SRCPV}"
SRCREV = "ef1837b2c37e90ed86edaccfb07a532aa5326d12"

S = "${WORKDIR}/git"

# NOTE: this is a Makefile-only piece of software, so we cannot generate much of the
# recipe automatically - you will need to examine the Makefile yourself and ensure
# that the appropriate arguments are passed in.

EXTRA_OEMAKE += " PREFIX=${prefix}"

do_install () {
	# This is a guess; additional arguments may be required
	oe_runmake install 'DESTDIR=${D}'
}

PACKAGES += "${PN}-example"

FILES_${PN}-example = " \
	/usr/bin/hello2 \
"
