# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit base

DESCRIPTION="Shamir's secret sharing scheme"
HOMEPAGE="http://point-at-infinity.org/ssss/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

SRC_URI="http://point-at-infinity.org/ssss/${PN}-${PV}.tar.gz"

DEPEND="app-doc/xmltoman
        dev-libs/gmp"

src_prepare(){
	epatch "${FILESDIR}/01_remove_strip.patch"
	epatch "${FILESDIR}/02_memset.patch"
}

src_install(){
	dobin ssss-split || die
	dobin ssss-combine || die
	doman ssss.1 || die
}
