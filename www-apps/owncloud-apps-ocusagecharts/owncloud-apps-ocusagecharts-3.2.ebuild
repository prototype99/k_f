# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Gives the ability to display various statistics about users."
HOMEPAGE="http://apps.owncloud.com/content/show.php/Usage+Charts+(+owncloud+7+)?content=166746"

LICENSE="MIT"
SLOT="0"
IUSE=""
SRC_URI="http://apps.owncloud.com/content/download.php?content=166746&id=1&tan=98284740 -> ocusagecharts.zip"
DEPEND=""
KEYWORDS="~amd64 ~x86"

RDEPEND=""

src_compile()
{
	#No compilation needed for this pacakge
	echo "ok" || die
}

src_install()
{
	insinto /var/lib/owncloud/apps
	doins -r *
}
