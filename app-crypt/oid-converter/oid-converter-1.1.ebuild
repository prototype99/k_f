# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="The OID converter is a handy little tool to convert ASN.1 OIDs from readable dotted decimal notation to binary hexadecimal Distinguished Encoding Rules (DER) representation and vice versa."
HOMEPAGE="http://www.rtner.de/software/oid.html"

LICENSE=""
SLOT="0"
IUSE=""
SRC_URI="http://www.rtner.de/software/oid.c"
DEPEND=""
KEYWORDS="~amd64 ~x86"

DOCS=( )

RDEPEND=""

src_unpack()
{
    mkdir -p ${S}
    cp ${DISTDIR}/oid.c ${S}
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
