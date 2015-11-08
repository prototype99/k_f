# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="SHA2 family (SHA256, SHA384, SHA512) functions for MariaDB/MySQL"
HOMEPAGE="http://www.kfwebs.net/articles/article/12/SHA512-SHA384-and-SHA256-support-in-MySQL"

LICENSE="WTFPL-2"
SLOT="0"
IUSE=""
SRC_URI="http://download.sumptuouscapital.com/gentoo/releases/${CATEGORY}/${PN}/mysql_sha-${PV}.cpp -> mysql_sha.cpp"

KEYWORDS="~amd64 ~x86"

CDEPEND="virtual/mysql
	dev-libs/crypto++"

DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

src_unpack()
{
	#This package ships as a single .cpp file, manual unpack to ensure the file is copied to the work dir
	mkdir -p "${S}" || die 
	cp "${DISTDIR}/mysql_sha.cpp" "${S}" || die
}

src_compile()
{
	#This package ships as a single .c file, manual compile process needed
	$(tc-getCXX) -shared -I/usr/include/mysql -L/usr/lib -fPIC -lcrypto++ -o mysql_sha.so mysql_sha.cpp || die
}

src_install()
{
	insinto /usr/lib/mysql/plugin/
	doins mysql_sha.so
	elog "###########################"
	elog "Manual configuration steps"
	elog "###########################"
	elog "CREATE FUNCTION sha256 RETURNS STRING SONAME 'mysql_sha.so';"
	elog "CREATE FUNCTION sha384 RETURNS STRING SONAME 'mysql_sha.so';"
	elog "CREATE FUNCTION sha512 RETURNS STRING SONAME 'mysql_sha.so';"
}
