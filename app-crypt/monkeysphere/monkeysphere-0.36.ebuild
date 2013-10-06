# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit user

DESCRIPTION="Leverage the OpenPGP web of trust for OpenSSH and Web authentication"
HOMEPAGE="http://web.monkeysphere.info/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
SRC_URI="http://archive.${PN}.info/debian/pool/${PN}/${PN::1}/${PN}/${PN}_${PV}.orig.tar.gz"
DEPEND=""
KEYWORDS="~x86 ~amd64"
DOCS=(README Changelog)
RDEPEND="app-crypt/gnupg
	dev-perl/Crypt-OpenSSL-RSA
	dev-perl/Digest-SHA1
	app-misc/lockfile-progs"

pkg_setup()
{
	ebegin "Creating named group and user"
	enewgroup monkeysphere
	enewuser monkeysphere -1 /bin/sh /var/lib/monkeysphere monkeysphere
	chown root:root /var/lib/monkeysphere || die
	chmod 751 /var/lib/monkeysphere || die
	eend ${?}
}

src_prepare()
{
	sed -i "s#share/doc/monkeysphere#share/doc/${PF}#" Makefile || die
}
