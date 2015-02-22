# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Gives the ability to display various statistics about users."
HOMEPAGE="http://apps.owncloud.com/content/show.php/Usage+Charts+(+owncloud+7+)?content=166746"

LICENSE="MIT"
SLOT="0"
IUSE=""
SRC_URI="http://apps.owncloud.com/CONTENT/content-files/166746-ocusagecharts.zip -> owncloud-apps-ocusagecharts-3.4.zip"

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=">=www-apps/owncloud-7.0.0"

MY_PN="ocusagecharts"
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
