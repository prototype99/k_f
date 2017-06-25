# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit eutils

DESCRIPTION="An RSS/Atom feed reader which can be synced with many mobile devices."
HOMEPAGE="http://apps.owncloud.com/content/show.php/News?content=168040"

LICENSE="AGPL"
SLOT="0"
IUSE=""
SRC_URI="https://apps.owncloud.com/CONTENT/content-files/174796-news.zip -> c${P}.zip"

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=">=www-apps/owncloud-9.1.0"

MY_PN="news"
S="${WORKDIR}/${MY_PN}/"

src_install()
{
	insinto "/var/lib/owncloud/apps/${MY_PN}"
	doins -r *
}

pkg_postinst()
{
	elog "This package install the application into /var/lib/owncloud/apps"
	elog "to use it two things needs to be configured."
	elog "(i) config/config.php needs to add apps path c.f. http://doc.owncloud.org/server/6.0/admin_manual/configuration/configuration_apps.html"
	elog "(ii) a symlink will have to be created pointing to the location of url variable from this folder"
}
