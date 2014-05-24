# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.90-r2.ebuild,v 1.13 2007/07/22 07:08:31 dirtyepic Exp $

EAPI=5

inherit font

MY_P="${P/_/}"

DESCRIPTION="Mozilla's typefont Fira"
HOMEPAGE="http://www.mozilla.org/en-US/styleguide/products/firefox-os/typeface/"
SRC_URI="http://dev.kfwebs.net/mozilla-fira-p20130923.zip -> mozilla-fira.zip"

#TODO: SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-apps/bdftopcf
		x11-apps/mkfontdir
		dev-lang/perl
		>=sys-apps/sed-4
		app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/Fira-master"
DOCS="README.md"
FONT_S="${WORKDIR}/Fira-master/ttf"
FONT_SUFFIX="ttf"
FONTDIR="/usr/share/fonts/${PN}"
