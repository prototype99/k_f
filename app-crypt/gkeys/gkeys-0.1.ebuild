# Copyright 2014-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-9999.ebuild,v 1.4 2015/01/01 22:15:34 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7 python3_3 python3_4)

inherit distutils-r1

DESCRIPTION="An OpenPGP/GPG key management tool and python libs"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Gentoo-keys"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

SRC_URI="http://dev.gentoo.org/~dolsen/releases/gkeys/gkeys-0.1.tar.bz2"

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-crypt/gnupg
	=dev-python/pyGPG-9999[${PYTHON_USEDEP}]
	=dev-python/ssl-fetch-9999[${PYTHON_USEDEP}]
	dev-python/snakeoil[${PYTHON_USEDEP}]
	app-crypt/gentoo-keys
	"

python_install_all() {
	distutils-r1_python_install_all
	keepdir /var/log/gkeys
	fperms g+w /var/log/gkeys
}

pkg_preinst() {
	chgrp users "${D}"/var/log/gkeys
}

pkg_postinst() {
	einfo
	einfo "This is experimental software."
	einfo "The API's it installs should be considered unstable"
	einfo "and are subject to change."
	einfo
	einfo "Please file any enhancement requests, or bugs"
	einfo "at https://bugs.gentoo.org"
	einfo "We are also on IRC @ #gentoo-keys of the freenode network"
	einfo
	ewarn "There may be some python 3 compatibility issues still."
	ewarn "Please help debug/fix/report them in bugzilla."
}
