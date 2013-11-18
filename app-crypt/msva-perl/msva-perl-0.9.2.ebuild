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

src_prepare()
{
	epatch "${FILESDIR}/${P}-makefile-version.patch"
	sed -i "s/##VERSION##/${PV}/" Makefile
}

src_install()
{
	insinto ${SITE_LIB}/Crypt/Monkeysphere
	insopts -m444
	doins Crypt/Monkeysphere/*.pm
	
	insinto ${SITE_LIB}/Crypt/Monkeysphere/MSVA
	doins Crypt/Monkeysphere/MSVA/*.pm
	
	insinto ${SITE_LIB}/Net/Server
	doins Net/Server/MSVA.pm
	
	insinto /usr/bin
	insopts -m555
	doins msva-perl
	doins msva-query-agent

	dodir "/etc/profile.d"
	insinto "/etc/profile.d"
	insopts -m755
	doins "${FILESDIR}/10-msva-perl.sh"
}
