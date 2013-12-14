# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-9999.ebuild,v 1.7 2013/05/03 07:56:29 djc Exp $

EAPI=5

inherit eutils autotools flag-o-matic user git-2

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"
HOMEPAGE="http://gnupg.org/"

LICENSE="GPL-2"
SLOT="2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

REQUIRED_USE=""
WANT_AUTOMAKE="1.13"
COMMON_DEPEND_LIBS="
    >=dev-libs/libassuan-2.1:0
    >=dev-libs/libgcrypt-1.6
    >=dev-libs/libgpg-error-1.11:0
    >=dev-libs/libksba-1.2.0:0
    dev-libs/npth:2.1
    >=net-misc/curl-7.10:0"

BDEPEND="dev-vcs/git:0
	media-gfx/transfig:0"

DEPEND="
	${COMMON_DEPEND_LIBS}
	net-nds/openldap:0=
	${BDEPEND}"

RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/gnupg_master_0002-Fix-building-with-GNU-Automake-1.13.patch"

	./autogen.sh || die "Autgen script failed"
}

src_configure() {
	econf \
		--program-prefix='gpg2.1-' \
		--infodir=/usr/share/info/gnupg2.1 \
		--datarootdir=/usr/share/gnupg2.1 \
		--docdir=/usr/share/doc/gnupg2.1 \
		--enable-maintainer-mode \
		--enable-symcryptrun \
		--enable-mailto \
		--enable-gpgtar
}

src_install(){
	default
	dosym gpg2.1-gpg2 /usr/bin/gpg2.1
	dosym gpg2.1-gpg-agent /usr/bin/gpg2.1-agent
}
