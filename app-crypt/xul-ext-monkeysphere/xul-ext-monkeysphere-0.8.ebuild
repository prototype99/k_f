# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Iceweasel/Firefox extension for using Monkeysphere on the web"
HOMEPAGE="http://web.monkeysphere.info/"

SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/x/xul-ext-monkeysphere/xul-ext-monkeysphere_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="media-gfx/inkscape"
RDEPEND="app-crypt/msva-perl"
DEPEND="|| ( www-client/firefox-bin www-client/firefox )"

src_install(){
	local emid=$(sed -n 's/.*<em:id>\(.*\)<\/em:id>.*/\1/p' ${S}/install.rdf | head -1)
	local cleanup=( NOTES Changelog Makefile install.rdf.template monkeysphere.xpi chrome/content/bad.svg  chrome/content/broken.svg  chrome/content/error.svg )

	# Delete files not to be installed from $S
	for i in "${cleanup[@]}"; do rm "${S}/$i"; done;

	local extinstalldir=()

	if has_version '>=www-client/firefox-bin-1.0'; then
		einfo "Binary version of Firefox found"
		extinstalldir+=/$(get_libdir)/firefox/extensions/${emid}
	fi

	if has_version '>=www-client/firefox-1.0'; then
		einfo "Source version of Firefox found"
		extinstalldir+=/usr/$(get_libdir)/firefox/browser/extensions/${emid}
	fi

	for i in "${extinstalldir[@]}"; do
		dodir "${i}"
		insinto "${i}"
		doins -r "${S}"/*
	done;
}
