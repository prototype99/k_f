# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="generates RFCs and IETF drafts from document source in XML"
HOMEPAGE="https://pypi.python.org/pypi/xml2rfc"
SRC_URI="https://pypi.python.org/packages/fd/83/cc243df99b45f45de99e2c3b5913137efc36f02a19c181adc98d401348c7/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"
