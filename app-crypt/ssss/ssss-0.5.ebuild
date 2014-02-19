# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Shamir's secret sharing scheme"
HOMEPAGE="http://point-at-infinity.org/ssss/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="http://point-at-infinity.org/ssss/ssss-${PV}.tar.gz"

DEPEND="app-doc/xmltoman:0=
        dev-libs/gmp:0="

src_prepare(){
	epatch "${FILESDIR}/${P}-remove_strip.patch"\
	       "${FILESDIR}/${P}-memset.patch"
}

src_install(){
	dobin ssss-split
	dobin ssss-combine
	doman ssss.1
}
