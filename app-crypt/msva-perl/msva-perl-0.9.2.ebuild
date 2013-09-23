# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit perl-module

if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_BRANCH="master"
	#EGIT_REPO_URI="git://git.monkeysphere.info/${PN}"
	EGIT_REPO_URI="git://tremily.us/monkeysphere-validation-agent.git
		http://http-git.tremily.us/monkeysphere-validation-agent.git"
	SRC_URI=""
else
	MY_P="${PN}_${PV}"
	SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/m/${PN}/${MY_P}.orig.tar.gz"
fi

DESCRIPTION="Monkeysphere public key validation daemon"
HOMEPAGE="http://web.monkeysphere.info/validation-agent/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="X"

#RESTRICT="test" # ssh connection failed

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
DEPEND="
	virtual/perl-Module-Build
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
	mkdir -p "${D}/etc/profile.d/"
	cp "${FILESDIR}/10-msva-perl.sh" "${D}/etc/profile.d/"
	chmod 0555  "${D}/etc/profile.d/10-msva-perl.sh"
}

pkg_postinst()
{
	use 'X' && elog "You seem to be using X. msva-perl has been set up to invoke and set env variables in /etc/profile.d/10-msva-perl.sh. If using another window manager you might want to set this for your window manager."
}
