# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1 git-2

DESCRIPTION="Monkeysign"
HOMEPAGE="http://web.monkeysphere.info/monkeysign/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="gnome"

EGIT_REPO_URI="git://git.monkeysphere.info/${PN}"
EGIT_MASTER="2.x"

DEPEND=""
RDEPEND="dev-python/pygtk:2=
	virtual/python-imaging:0=
	media-gfx/zbar:0=[python,gtk,imagemagick]
	media-gfx/qrencode-python:0=
	dev-python/setuptools:0=
	app-crypt/gnupg:0=
	gnome? ( x11-themes/gnome-icon-theme:0= )
	dev-python/docutils:0=
"

src_prepare()
{
	epatch "${FILESDIR}/monkeysign-1.1-basename.patch"\
	       "${FILESDIR}/${PN}-1.1-rst2s5.patch"\
	       "${FILESDIR}/${P}-rst2s5.patch"\
       	       "${FILESDIR}/${P}-fr_po.patch"

	distutils-r1_src_prepare
}

src_install()
{
	distutils-r1_src_install
	domenu "${FILESDIR}/monkeysign.desktop"
}
