# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

DESCRIPTION="Tool to create xml suitable for xml2rfc from Markup"
HOMEPAGE="https://github.com/miekg/pandoc2rfc"

LICENSE="public-domain"
SLOT="0"
IUSE=""
SRC_URI="https://github.com/miekg/pandoc2rfc/archive/${PV}.tar.gz"

KEYWORDS="~amd64"

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}
	     app-text/pandoc
		 app-text/xml2rfc"
