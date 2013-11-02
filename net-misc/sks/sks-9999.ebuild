# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sks/sks-1.1.2.ebuild,v 1.4 2012/02/07 00:34:06 kingtaco Exp $

EAPI=4

inherit eutils multilib mercurial

DESCRIPTION="SKS Keyserver"
HOMEPAGE="https://bitbucket.org/skskeyserver/sks-keyserver"
if [[ ${PV} == "9999" ]]; then
EHG_REPO_URI="https://bitbucket.org/skskeyserver/sks-keyserver"
EHG_REVISION="tip"
else
SRC_URI="https://bitbucket.org/skskeyserver/sks-keyserver/downloads/${P}.tgz"
fi;
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd optimize test"

DEPEND="dev-lang/ocaml
		dev-ml/cryptokit
		sys-libs/db:5.2"
RDEPEND="${DEPEND}"

pkg_setup() {
	ebegin "Creating named group and user"
	enewgroup sks
	enewuser sks -1 -1 /var/lib/sks sks
}

src_prepare() {
	cp Makefile.local.unused Makefile.local || die
	sed -i \
		-e "s:^BDBLIB=.*$:BDBLIB=-L/usr/$(get_libdir):g" \
		-e "s:^BDBINCLUDE=.*$:BDBINCLUDE=-I/usr/include/db5.2/:g" \
		-e "s:^LIBDB=.*$:LIBDB=-ldb-5.2:g" \
		-e "s:^PREFIX=.*$:PREFIX=${D}/usr:g" \
		-e "s:^MANDIR=.*$:MANDIR=${D}/usr/share/man:g" \
		Makefile.local || die
	sed -i \
		-e 's:^CAMLINCLUDE= -I lib -I bdb$:CAMLINCLUDE= -I lib -I bdb -I +cryptokit:g' \
		-e 's:-Werror-implicit-function-declaration::g' \
		Makefile bdb/Makefile || die
}

src_compile() {
	emake dep
	emake -j1 all
	if use optimize; then
		emake all.bc
	fi
}

src_test() {
	./sks unit_test
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
	use systemd && systemd_dounit "${FILESDIR}/sks-db.service"
	use systemd && systemd_dounit "${FILESDIR}/sks-recon.service"

	mkdir -p $D/var/lib/sks/web.typical
	cp $S/sampleConfig/DB_CONFIG $D/var/lib/sks/DB_CONFIG.typical
	cp $S/sampleConfig/sksconf.typical $D/var/lib/sks/sksconf.typical
	cp $S/sampleWeb/HTML5/* $D/var/lib/sks/web.typical/

	keepdir /var/lib/sks
}

pkg_postinst() {
	einfo "To get sks running, first build the database,"
	einfo "start the databse, import atleast one key, then"
	einfo "run a cleandb. See the sks man page for more"
	einfo "information"
	einfo "Typical DB_CONFIG file and sksconf has been installed"
	einfo "in /var/lib/sks and can be used as templates by renaming"
	einfo "to remove the .typical extension. The DB_CONFIG file has"
	einfo "to be in place before doing the database build, or the BDB"
	einfo "environment has to be manually cleared from both KDB and PTree"
	einfo "using db4.8_recover -h and db4.8_checkpoint -1h"
	einfo "Additionally a sample web interface has been installed as"
	einfo "web.typical in /var/lib/sks that can be used by renaming it to web"
	einfo "Important: It is strongly recommended to set up SKS behind a"
	einfo "reverse proxy. Instructions on properly configuring SKS can be"
	einfo "found at https://bitbucket.org/skskeyserver/sks-keyserver/wiki/Peering"
}

