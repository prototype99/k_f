# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="Tool to easily embed LaTeX math in html pages"
HOMEPAGE="http://www.forkosh.com/mathtex.html"

LICENSE="GPL-3"
SLOT="0"
IUSE="png"
SRC_URI="https://download.sumptuouscapital.com/gentoo/releases/${CATEGORY}/${PN}/${P}.zip"

KEYWORDS="~amd64 ~x86"

CDEPEND="virtual/latex-base
	app-text/dvipng"

DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

S=${WORKDIR}

src_compile()
{
        #This package ships as a single .c file, manual compile process needed
        $(tc-getCC) mathtex.c \
            -DLATEX=\"$(/usr/bin/which latex)\"   \
            -DDVIPNG=\"$(/usr/bin/which dvipng)\"   \
            -DCACHE="/var/lib/mathtex" \
            $(use png && echo "-DPNG") \
            -o mathtex.cgi || die
}

src_install()
{
	dodir /var/lib/${PN}
	fperms 755 /var/lib/${PN}
	dodoc README
	exeinto /usr/libexec/${PN}
	doexe ${PN}.cgi
}

pkg_postinst()
{
	elog "${PN}.cgi has been installed in /usr/libexec/${PN},"
	elog "if you want to enable this for a webserver please create a symlink"\
	     " to your cgi-bin"
}
