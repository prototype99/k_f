# Copyright 2014-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys-gen/gkeys-gen-9999.ebuild,v 1.2 2015/01/01 20:28:44 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7 python3_3 python3_4)

inherit distutils-r1

DESCRIPTION="An OpenPGP/GPG tool for generating keys to spec"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Gentoo-keys"
SRC_URI="http://dev.gentoo.org/~dolsen/releases/gkeys/gkeys-0.1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}
	app-crypt/gnupg
	dev-python/snakeoil[${PYTHON_USEDEP}]
	dev-python/pygpgme[${PYTHON_USEDEP}]
	=app-crypt/gkeys-0.1[${PYTHON_USEDEP}]
	"

S="${WORKDIR}/$P/gkeys-gen"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# copy these 2 into our subdir from the master level
	cp ../LICENSE ./ || die "cp LICENSE failed"
	cp ../README.md ./ || die "cp README.me failed"
}

pkg_postinst() {
	einfo
	einfo "This is experimental software."
	einfo "The API's it installs should be considered unstable"
	einfo "and are subject to change."
	einfo
	einfo "Please file any enhancement requests, or bugs"
	einfo "at https://bugs.gentoo.org"
	einfo "We are also on IRC @ #gentoo-keys of the Freenode network"
	einfo
	ewarn "There may be some Python 3 compatibility issues still."
	ewarn "Please help debug, fix and report them in Bugzilla."
}
