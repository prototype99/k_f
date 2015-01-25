# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=5

inherit autotools flag-o-matic user git-2

DESCRIPTION="General purpose crypto library based on the code used in GnuPG"
HOMEPAGE="http://gnupg.org/"

WANT_AUTOMAKE=1.14
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"

LICENSE="GPL-2"
SLOT="0/20"
KEYWORDS=""

IUSE=""

REQUIRED_USE=""
#Texinfo version 4.8 segfaults, force higher version.  
CDEPEND=">=dev-libs/libgpg-error-1.13"
DEPEND="
	>=sys-apps/texinfo-5.2:0
	media-gfx/transfig
	app-text/ghostscript-gpl
	${CDEPEND}
"
RDEPEND="${CDEPEND}"

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf \
		--enable-maintainer-mode
}
