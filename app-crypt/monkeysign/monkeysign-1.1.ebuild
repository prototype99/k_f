# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A user-friendly commandline tool to sign OpenGPG keys"
HOMEPAGE="http://web.monkeysphere.info/monkeysign/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_URI="mirror://debian/pool/main/m/monkeysign/monkeysign_${PV}.tar.gz"

CDEPEND="dev-python/pygtk[${PYTHON_USEDEP}]
	media-gfx/zbar:0=[python,gtk,imagemagick]
	media-gfx/qrencode-python:0=
	virtual/python-imaging:0="

DEPEND="dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	${CDEPEND}"

RDEPEND="app-crypt/gnupg:0=
	virtual/mta
	${CDEPEND}"

PATCHES=("${FILESDIR}/${P}-basename.patch"
         "${FILESDIR}/${P}-rst2s5.patch"
	)

src_install()
{
	distutils-r1_src_install
	domenu "${FILESDIR}/monkeysign.desktop"
}
