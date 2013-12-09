# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit autotools flag-o-matic user git-2

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"
HOMEPAGE="http://gnupg.org/"

LICENSE="GPL-2"
SLOT="2.1"
KEYWORDS="~amd64 ~x86"

IUSE=""

REQUIRED_USE=""
#Texinfo version 4.8 segfaults, force higher version.  
DEPEND="
	>=sys-apps/texinfo-5.2:0
"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/0002-Fix-building-with-GNU-Automake-1.13.patch";
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	#Installing into /usr/local/ rather than /usr using configure 
	./configure \
		--enable-maintainer-mode
}
