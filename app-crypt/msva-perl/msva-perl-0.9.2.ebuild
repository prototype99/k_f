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
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/perl-Module-Build:0="

RDEPEND="
	dev-perl/Crypt-X509:0=
	dev-perl/File-HomeDir:0=
	dev-perl/File-ShareDir:0=
	dev-perl/GnuPG-Interface:0=
	dev-perl/HTTP-Server-Simple:0=
	dev-perl/HTTP-Message:0=
	dev-perl/JSON:0=
	dev-perl/config-general:0=
	dev-perl/libwww-perl:0=
	dev-perl/net-server:0=
	dev-perl/regexp-common:0=
	${DEPEND}"

src_prepare()
{
	sed -i -e "s|^VERSION :=.*|VERSION=${PV}|" \
	       -e "s|^DEBIAN_VERSION=.*|DEBIAN_VERSION=${PV}|" Makefile || die
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

	dobin msva-perl
	doman msva-perl.1
	dobin msva-query-agent
	doman msva-query-agent.1

	insinto "/etc/profile.d"
	insopts -m755
	doins "${FILESDIR}/10-msva-perl.sh"
}
