# Copyright 2014-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-9999.ebuild,v 1.2 2014/12/25 20:58:50 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

MY_PN="ejson"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Extensible json serializer/deserializer library"
HOMEPAGE="https://github.com/Yipit/ejson"
SRC_URI="https://pypi.python.org/packages/source/p/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

S="${WORKDIR}/${MY_P}"
