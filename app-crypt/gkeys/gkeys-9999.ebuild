# Copyright 2014-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-9999.ebuild,v 1.1 2014/12/24 23:31:26 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7 python3_3 python3_4)

#EGIT_PROJECT="gentoo-keys.git"
EGIT_BRANCH="master"

inherit distutils-r1 git-r3

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/gentoo-keys.git"

DESCRIPTION="A Openpgp/gpg key management program and python libs"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Gentoo-keys"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS=""

DEPEND="net-misc/curl
	app-crypt/gentoo-keys
	app-crypt/gnupg
	=dev-python/pyGPG-9999[${PYTHON_USEDEP}]
	=dev-python/ssl-fetch-9999[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	"

S="${WORKDIR}/$P/gkeys"

python_prepare_all() {
	distutils-r1_python_prepare_all
	# copy these 2 into our subdir from the master level
	cp ../LICENSE ./ || die "cp LICENSE failed"
	cp ../README.md ./ || die "cp README.me failed"
}

pkg_postinst() {
	mkdir -p "/var/lib/gentoo/gkeys/seeds"
	curl "https://api.gentoo.org/gentoo-keys/seeds/gentoodevs.seeds" > /var/lib/gentoo/gkeys/seeds/gentoodevs.seeds
	curl "https://api.gentoo.org/gentoo-keys/seeds/gentoodevs.seeds.sig" > /var/lib/gentoo/gkeys/seeds/gentoodevs.seeds.sig
	gkeys verify -C gentoo \
           -F /var/lib/gentoo/gkeys/seeds/gentoodevs.seeds \
           -s /var/lib/gentoo/gkeys/seeds/gentoodevs.seeds.sig
	if [[ $? == "0" ]]; then
		gkeys installkey -C gentoo-devs
	fi
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
