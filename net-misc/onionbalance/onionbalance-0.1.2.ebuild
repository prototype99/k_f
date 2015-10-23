# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1

DESCRIPTION="load-balancing and redundancy for Tor hidden services"
HOMEPAGE="https://pypi.python.org/pypi/OnionBalance"
SRC_URI="https://github.com/DonnchaC/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

IUSE=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

CDEPEND=">=dev-python/pycrypto-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.11[${PYTHON_USEDEP}]
        >=net-libs/stem-1.4.1b[${PYTHON_USEDEP}]
        >=dev-python/future-0.14.3[${PYTHON_USEDEP}]
	"

DEPEND="${CDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="${CDEPEND}
	>=net-misc/tor-0.2.7.1
	"

REQUIRED_USE=""
