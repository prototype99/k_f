# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/monafont/monafont-2.90-r2.ebuild,v 1.13 2007/07/22 07:08:31 dirtyepic Exp $

EAPI=5

inherit font

MY_P="${P/_/}"

DESCRIPTION="Eika's typefont"
HOMEPAGE="http://eika.no"
SRC_URI="http://kfwebs.com/gentoo/eika-p20140601.tar.bz2 -> eika.tar.bz2"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/Eika"
DOCS=""
FONT_S="${WORKDIR}/Eika"
FONT_SUFFIX="otf"
FONTDIR="/usr/share/fonts/${PN}"
