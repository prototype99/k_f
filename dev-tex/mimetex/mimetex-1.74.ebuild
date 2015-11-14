# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Tool to easily embed LaTeX math in html pages"
HOMEPAGE="http://www.forkosh.com/mimetex.html"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
SRC_URI="https://download.sumptuouscapital.com/gentoo/releases/${CATEGORY}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~x86"

CDEPEND="media-libs/giflib"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

S=${WORKDIR}

src_compile()
{
	#This package ships as a single .c file, manual compile process needed
	$(tc-getCC) -DAA mimetex.c gifsave.c -lm -o mimetex.cgi || die
:;
}

src_install()
{
	dodoc README
	exeinto /usr/libexec/mimetex
	doexe mimetex.cgi
}

pkg_postinst()
{
	elog "mimetex.cgi has been installed in /usr/libexec/mimetex,"
	elog "if you want to enable this for a webserver please create a symlink"\
	     " to your cgi-bin"
}
