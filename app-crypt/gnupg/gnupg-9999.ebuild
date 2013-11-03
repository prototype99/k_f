# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-9999.ebuild,v 1.7 2013/05/03 07:56:29 djc Exp $

EAPI=4

inherit eutils autotools flag-o-matic user git-2

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"
HOMEPAGE="http://gnupg.org/"

LICENSE="GPL-2"
SLOT="2.1"
KEYWORDS="~amd64 ~x86"
IUSE="+localprefix"

REQUIRED_USE=""

COMMON_DEPEND_LIBS="
    >=dev-libs/libassuan-2.1
    >=dev-libs/libgcrypt-1.5
    >=dev-libs/libgpg-error-1.11
    >=dev-libs/libksba-1.2.0
    >=dev-libs/npth-0.91
    >=net-misc/curl-7.10"

DEPEND="
	${COMMON_DEPEND_LIBS}
	net-nds/openldap
	media-gfx/transfig
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/gnupg_master_0002-Fix-building-with-GNU-Automake-1.13.patch"
}

src_configure() {
	local myconf2; 

	if use localprefix; then
		myconf2+=(
			--prefix=/usr/local
			--datarootdir=/usr/local
		)
	fi

	./autogen.sh || die

	./configure \
		${myconf2[@]} \
		--enable-maintainer-mode \
		--enable-symcryptrun \
		--enable-mailto \
		--enable-gpgtar || die
}
