# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Monkeysign"
HOMEPAGE="http://web.monkeysphere.info/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gnome"

SRC_URI="http://cdn.debian.net/debian/pool/main/m/monkeysign/monkeysign_${PV}.tar.gz"

DEPEND=""
RDEPEND="
	dev-python/pygtk
	virtual/python-imaging
	media-gfx/zbar[python,gtk,imagemagick]
	media-gfx/qrencode-python
	dev-python/setuptools
	app-crypt/gnupg
	gnome? ( x11-themes/gnome-icon-theme )
"

src_prepare(){
	epatch "${FILESDIR}/${P}_basename.patch"
}

pkg_postinst()
{
	use gnome && cp ${FILESDIR}/monkeysign.desktop /usr/share/applications/ || die	
	use gnome && update-desktop-database || die
}
