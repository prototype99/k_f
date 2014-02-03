# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1

DESCRIPTION="Monkeysign"
HOMEPAGE="http://web.monkeysphere.info/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

SRC_URI="mirror://debian/pool/main/m/monkeysign/monkeysign_${PV}.tar.gz"

DEPEND="dev-python/docutils:0=
	dev-python/pygtk:2=
	media-gfx/zbar:0=[python,gtk,imagemagick]
	media-gfx/qrencode-python:0="

RDEPEND="${DEPEND}
	virtual/python-imaging:0=
	dev-python/setuptools:0=
	app-crypt/gnupg:0=
	gnome? ( x11-themes/gnome-icon-theme:0= )"

src_prepare()
{
	epatch "${FILESDIR}/${P}-basename.patch"\
	       "${FILESDIR}/${P}-rst2s5.patch"
	distutils-r1_src_prepare
}

src_install()
{
	distutils-r1_src_install
	domenu "${FILESDIR}/monkeysign.desktop"
}
