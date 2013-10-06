# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit perl-module

SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/m/msva-perl/msva-perl_${PV}.orig.tar.gz"

DESCRIPTION="Monkeysphere public key validation daemon"
HOMEPAGE="http://web.monkeysphere.info/validation-agent/"

LICENSE="GPL-3"
SLOT="0"
IUSE="X"
DEPEND="
	virtual/perl-Module-Build
	"

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
	epatch "${FILESDIR}/01_Makefile.patch"
	sed -i "s/##VERSION##/${PV}/" Makefile
	epatch "${FILESDIR}/02_Makefile.patch"
	sed -i 's/##PERL##/${ED}usr\/local\/lib\/site_perl/' Makefile
}

src_install() {
    mytargets="install doc=/usr/share/doc/${P}"
	perl-module_src_install
	mkdir -p "${D}/etc/profile.d/" || die
	cp "${FILESDIR}/10-msva-perl.sh" "${D}/etc/profile.d/" || die
	chmod 0555  "${D}/etc/profile.d/10-msva-perl.sh" || die
}

pkg_postinst()
{
	use 'X' && elog "You seem to be using X. msva-perl has been set up to invoke and set env variables in /etc/profile.d/10-msva-perl.sh. If using another window manager you might want to set this for your window manager."
}
