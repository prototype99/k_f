# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sks/sks-1.1.2.ebuild,v 1.4 2012/02/07 00:34:06 kingtaco Exp $

EAPI=5

inherit eutils multilib user readme.gentoo systemd

DESCRIPTION="An OpenPGP keyserver whose goal is to provide easy to deploy, decentralized, and highly reliable synchronization"
HOMEPAGE="https://bitbucket.org/skskeyserver/sks-keyserver"
SRC_URI="http://bitbucket.org/skskeyserver/sks-keyserver/downloads/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="optimize test"

DEPEND="dev-lang/ocaml
		dev-ml/cryptokit
		sys-libs/db:4.8"
RDEPEND="${DEPEND}"

pkg_setup() {
	ebegin "Creating named group and user"
	enewgroup sks
	enewuser sks -1 -1 /var/lib/sks sks
}

src_prepare() {
	epatch "${FILESDIR}/${P}-ECC_OID_fix_x86.patch"

	cp Makefile.local.unused Makefile.local || die
	sed -i \
		-e "s:^BDBLIB=.*$:BDBLIB=-L/usr/$(get_libdir):g" \
		-e "s:^BDBINCLUDE=.*$:BDBINCLUDE=-I/usr/include/db4.8/:g" \
		-e "s:^LIBDB=.*$:LIBDB=-ldb-4.8:g" \
		-e "s:^PREFIX=.*$:PREFIX=${D}/usr:g" \
		-e "s:^MANDIR=.*$:MANDIR=${D}/usr/share/man:g" \
		Makefile.local || die
	sed -i \
		-e 's:^CAMLINCLUDE= -I lib -I bdb$:CAMLINCLUDE= -I lib -I bdb -I +cryptokit:g' \
		-e 's:-Werror-implicit-function-declaration::g' \
		Makefile bdb/Makefile || die
	sed -i \
		-e 's:/usr/sbin/sks:/usr/bin/sks:g' \
		sks_build.sh || die
}

src_compile() {
	emake dep
	emake -j1 all
	if use optimize; then
		emake all.bc
	fi
}

src_test() {
	./sks unit_test || die
}

src_install() {
	if use optimize; then
		emake install.bc
		dosym /usr/bin/sks.bc usr/bin/sks
		dosym /usr/bin/sks_add_mail.bc usr/bin/sks_add_mail
	else
		emake install
	fi

	dodoc README.md

	newinitd "${FILESDIR}/sks-db.runscript" sks-db
	newinitd "${FILESDIR}/sks-recon.runscript" sks-recon
	newconfd "${FILESDIR}/sks-confd" sks
	systemd_dounit "${FILESDIR}/sks-db.service"
	systemd_dounit "${FILESDIR}/sks-recon.service"

	dodir "${D}/var/lib/sks/web.typical"
	insinto /var/lib/sks
	newins sampleConfig/DB_CONFIG DB_CONFIG.typical
	newins sampleConfig/sksconf sksconf.typical
	insinto /var/lib/sks/web.typical
	doins sampleWeb/HTML5/*

	keepdir /var/lib/sks
}

pkg_postinst() {
	readme.gentoo_print_elog
	ewarn "Note when upgrading from earlier versions of SKS"
	ewarn "===================="
	ewarn "The default values for pagesize settings have changed. To continue"
	ewarn "using an existing DB without rebuilding, explicit settings have to be"
	ewarn "added to the sksconf file."
	ewarn "pagesize:       4"
	ewarn "ptree_pagesize: 1"
}
