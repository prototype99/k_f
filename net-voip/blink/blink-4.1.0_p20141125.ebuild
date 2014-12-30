# Copyright 2014-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gkeys/gkeys-9999.ebuild,v 1.2 2014/12/25 20:58:50 dolsen Exp $

EAPI="5"

PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="SIP-client"
HOMEPAGE="http://ag-projects.com/"
SRC_URI="http://download.sumptuouscapital.com/gentoo/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

CDEPEND="dev-python/PyQt4[webkit,${PYTHON_USEDEP}]
	 dev-python/lxml[${PYTHON_USEDEP}]
	 dev-python/cython[${PYTHON_USEDEP}]
	 dev-python/python-application[${PYTHON_USEDEP}]
	 dev-python/python-cjson[${PYTHON_USEDEP}]
	 dev-python/twisted-core[${PYTHON_USEDEP}]
	 dev-python/python-sipsimple[${PYTHON_USEDEP}]
	 dev-python/zope-interface[${PYTHON_USEDEP}]
	 dev-python/python-dateutil[${PYTHON_USEDEP}]
	 dev-python/django[${PYTHON_USEDEP}]
	 dev-python/python-msrplib[${PYTHON_USEDEP}]
	 dev-python/redis-py[${PYTHON_USEDEP}]
	 net-libs/libvncserver"

DEPEND="${CDEPEND}"

RDEPEND="${CDEPEND}"

S="${WORKDIR}/blink-qt"

