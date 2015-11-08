# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="The OID converter is a tool to convert ASN.1 OIDs between dotted decimal notation and hexadecimal"
HOMEPAGE="http://www.rtner.de/software/oid.html"

LICENSE="WTFPL-2"
SLOT="0"
IUSE=""
SRC_URI="http://download.sumptuouscapital.com/gentoo/releases/${CATEGORY}/${PN}/oid-${PV}.c -> oid.c"
DEPEND=""
KEYWORDS="~amd64 ~x86"

RDEPEND=""

src_unpack()
{
	#This package ships as a single .c file, manual unpack to ensure the file is copied to the work dir
	mkdir -p "${S}" || die 
	cp "${DISTDIR}/oid.c" "${S}" || die
}

src_compile()
{
	#This package ships as a single .c file, manual compile process needed
	$(tc-getCC) ${LDFLAGS} ${CFLAGS} -o ${PN} oid.c || die
}

src_install()
{
	dobin ${PN}
}
