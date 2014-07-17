# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit autotools flag-o-matic user git-2

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"
HOMEPAGE="http://gnupg.org/"

LICENSE="GPL-2"
SLOT="0/20"
KEYWORDS=""

IUSE=""

REQUIRED_USE=""
#Texinfo version 4.8 segfaults, force higher version.  
DEPEND="
	>=sys-apps/texinfo-5.2:0
	>=dev-libs/libgpg-error-1.13
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/0002-Fix-building-with-GNU-Automake-1.13.patch";
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf \
		--enable-maintainer-mode
}
