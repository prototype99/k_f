# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-9999.ebuild,v 1.7 2013/05/03 07:56:29 djc Exp $

EAPI=4

inherit autotools flag-o-matic user git-2

DESCRIPTION="nPth: New GNU Portable Threads Library"
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"
HOMEPAGE="http://gnupg.org/"

LICENSE="GPL-2"
SLOT="2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/npth_master_0001-Switch-to-non-deprecated-form-of-GNU-Automake-initia.patch"
	#epatch "${FILESDIR}/npth_master_0002-Fix-building-with-GNU-Automake-1.13.patch"
	./autogen.sh
	eautoreconf
}

src_configure() {
	econf \
		${myconf} \
		--enable-maintainer-mode
}
