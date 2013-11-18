# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils user

DESCRIPTION="Leverage the OpenPGP web of trust for OpenSSH and Web authentication"
HOMEPAGE="http://web.monkeysphere.info/"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/m/monkeysphere/monkeysphere_${PV}.orig.tar.gz"
DEPEND=""
KEYWORDS="~x86 ~amd64"
DOCS=(README Changelog)
RDEPEND="
	app-crypt/gnupg
	|| ( net-analyzer/netcat net-misc/socat )
	dev-perl/Crypt-OpenSSL-RSA
	dev-perl/Digest-SHA1
	app-misc/lockfile-progs"

src_prepare()
{
	epatch "${FILESDIR}/${P}_default_shell.patch"
	epatch "${FILESDIR}/${P}_non_default_port.patch"
	epatch "${FILESDIR}/${P}_userid_empty_line.patch"
	sed -i "s#share/doc/monkeysphere#share/doc/${PF}#" Makefile || die
}

pkg_postinst(){
	einfo "Creating named group and user"
	enewgroup monkeysphere
	enewuser monkeysphere -1 -1 /var/lib/monkeysphere monkeysphere
	mkdir -p /var/lib/monkeysphere || die
	chown root:monkeysphere /var/lib/monkeysphere || die
	chmod 751 /var/lib/monkeysphere || die

	monkeysphere-authentication setup || die
}
