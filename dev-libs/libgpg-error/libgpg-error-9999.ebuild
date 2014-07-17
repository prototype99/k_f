# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-9999.ebuild,v 1.7 2013/05/03 07:56:29 djc Exp $

EAPI=5

inherit autotools flag-o-matic user git-2

DESCRIPTION="libgpg-error: Error codes used by GnuPG, libgcrypt etc"
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"
HOMEPAGE="http://gnupg.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

REQUIRED_USE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh || die "Autogen failed"
	eautoreconf
}

src_configure() {
	econf \
		${myconf} \
		--enable-maintainer-mode
}
