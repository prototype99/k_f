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
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

SRC_URI="http://cdn.debian.net/debian/pool/main/m/monkeysign/monkeysign_${PV}.tar.gz"

DEPEND=""
RDEPEND="dev-python/pygtk:2=
	virtual/python-imaging:0=
	media-gfx/zbar:0=[python,gtk,imagemagick]
	media-gfx/qrencode-python:0=
	dev-python/setuptools:0=
	app-crypt/gnupg:0=
	gnome? ( x11-themes/gnome-icon-theme:0= )
"

src_prepare()
{
	epatch "${FILESDIR}/${P}-basename.patch"
}

src_install()
{
	default_src_install
	if use gnome; then
		insinto /usr/share/applications
		doins "${FILESDIR}/monkeysign.desktop"
	fi;
}

pkg_postinst()
{
	use gnome && update-desktop-database || die
}

pkg_postrm()
{
	use gnome && update-desktop-database || die
}
