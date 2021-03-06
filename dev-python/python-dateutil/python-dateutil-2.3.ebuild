# Copyright 2014-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-9999.ebuild,v 1.2 2014/12/25 20:58:50 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="Powerful extensions to the datetime module available in the Python standard library."
HOMEPAGE="https://dateutil.readthedocs.org/"
SRC_URI="https://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"
