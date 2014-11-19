# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Gives the ability to display various statistics about users."
HOMEPAGE="http://apps.owncloud.com/content/show.php/Usage+Charts+(+owncloud+7+)?content=166746"

LICENSE="MIT"
SLOT="0"
IUSE=""
SRC_URI="http://apps.owncloud.com/CONTENT/content-files/166746-ocusagecharts.zip -> ocusagecharts.zip"
DEPEND=""
KEYWORDS="~amd64 ~x86"

RDEPEND=""

MY_PN="ocusagecharts"
S="${WORKDIR}/${MY_PN}/"

src_compile()
{
	#No compilation needed for this pacakge
	echo "ok" || die
}

src_install()
{
	insinto "/var/lib/owncloud/apps/${MY_PN}"
	doins -r *
}
