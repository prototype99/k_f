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
SRC_URI="mirror://debian/pool/monkeysphere/m/monkeysphere/monkeysphere_${PV}.orig.tar.gz"
DEPEND=""
KEYWORDS="~amd64 ~x86"

DOCS=( README Changelog )

RDEPEND="app-crypt/gnupg:0=
	|| ( net-analyzer/netcat:0= net-misc/socat:0= )
	dev-perl/Crypt-OpenSSL-RSA:0=
	dev-perl/Digest-SHA1:0=
	app-misc/lockfile-progs:0="

pkg_setup()
{
	einfo "Creating named group and user"
	enewgroup monkeysphere
	enewuser monkeysphere -1 -1 /var/lib/monkeysphere monkeysphere
}

src_prepare()
{
	epatch "${FILESDIR}/${P}_default_shell.patch"\
	       "${FILESDIR}/${P}_non_default_port.patch"\
	       "${FILESDIR}/${P}_userid_empty_line.patch"\
	       "${FILESDIR}/${P}_openpgp2ssh_sanity_check.patch"
	sed -i "s#share/doc/monkeysphere#share/doc/${PF}#" Makefile || die
}

src_install()
{
	default
	dodir /var/lib/monkeysphere
	fowners root:monkeysphere /var/lib/monkeysphere
	fperms 751 /var/lib/monkeysphere
}

pkg_postinst()
{
	monkeysphere-authentication setup || die
}