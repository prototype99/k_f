# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit perl-module

SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/m/msva-perl/msva-perl_${PV}.orig.tar.gz"

DESCRIPTION="Monkeysphere public key validation daemon"
HOMEPAGE="http://web.monkeysphere.info/validation-agent/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
DEPEND="virtual/perl-Module-Build"

KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-perl/Crypt-X509
	dev-perl/File-HomeDir
	dev-perl/File-ShareDir
	dev-perl/GnuPG-Interface
	dev-perl/HTTP-Server-Simple
	dev-perl/HTTP-Message
	dev-perl/JSON
	dev-perl/config-general
	dev-perl/libwww-perl
	dev-perl/net-server
	dev-perl/regexp-common
	"

src_prepare() {
	epatch "${FILESDIR}/${P}-makefile-version.patch"
	sed -i "s/##VERSION##/${PV}/" Makefile
	epatch "${FILESDIR}/${P}-makefile-install-target.patch"
	sed -i 's/##PERL##/${ED}usr\/local\/lib\/site_perl/' Makefile
}

src_install() {
	mytargets="install doc=/usr/share/doc/${P}"
	perl-module_src_install
	dodir "/etc/profile.d"
	insinto "/etc/profile.d"
	insopts -m755
	doins "${FILESDIR}/10-msva-perl.sh"
}
