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
SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/m/monkeysphere/monkeysphere_${PV}.orig.tar.gz"
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
	mkdir -p /var/lib/monkeysphere/authentication/sphere || die
	chown root:monkeysphere /var/lib/monkeysphere || die
	chown root:monkeysphere /var/lib/monkeysphere/authentication || die
	chown monkeysphere:monkeysphere /var/lib/monkeysphere/authentication/sphere || die
	chmod 755 /var/lib/monkeysphere || die
	eend ${?}
}

src_prepare()
{
	sed -i "s#share/doc/monkeysphere#share/doc/${PF}#" Makefile || die
}
