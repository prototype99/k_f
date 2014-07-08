# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit git-2 python-r1

DESCRIPTION="Drunken Bishop algorithm for OpenPGP as applied to OpenSSH keys"
HOMEPAGE="https://pthree.org/2014/04/18/the-drunken-bishop-for-openpgp-keys/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="https://github.com/atoponce/${PN}"

DEPEND=""
RDEPEND=""

src_prepare()
{
	python_copy_sources
}

src_install()
{
	do_install()
	{
		python_fix_shebang keyart
		python_doexe keyart
	}
	python_foreach_impl do_install
}
