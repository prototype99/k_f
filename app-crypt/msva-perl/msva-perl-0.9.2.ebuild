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
IUSE="test"

#RESTRICT="test" # ssh connection failed

RDEPEND="
	perl-gcpan/Crypt-X509
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
	app-portage/g-cpan
	virtual/perl-Module-Build
	test? ( ${RDEPEND} )
	"

src_install() {
	mytargets="install --install-path doc=/usr/share/doc/${P}"
	perl-module_src_install
}
