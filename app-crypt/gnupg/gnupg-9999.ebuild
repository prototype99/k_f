# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-2.1.0.ebuild,v 1.4 2014/11/09 01:42:34 k_f Exp $

EAPI="5"

inherit eutils flag-o-matic toolchain-funcs git-2

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"

EGIT_REPO_URI="git://git.gnupg.org/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="bzip2 doc +gnutls ldap nls readline static selinux smartcard tools usb"

RESTRICT="test"

COMMON_DEPEND_LIBS="
	dev-libs/npth
	>=dev-libs/libassuan-2
	>=dev-libs/libgcrypt-1.6.2
	>=dev-libs/libgpg-error-1.15
	>=dev-libs/libksba-1.0.7
	>=net-misc/curl-7.10
	gnutls? ( >=net-libs/gnutls-3.0 )
	sys-libs/zlib
	ldap? ( net-nds/openldap )
	bzip2? ( app-arch/bzip2 )
	readline? ( sys-libs/readline )
	smartcard? ( usb? ( virtual/libusb:0 ) )
	"
COMMON_DEPEND_BINS="|| ( app-crypt/pinentry app-crypt/pinentry-qt )"

# Existence of executables is checked during configuration.
DEPEND="${COMMON_DEPEND_LIBS}
	${COMMON_DEPEND_BINS}
	static? (
		>=dev-libs/libassuan-2[static-libs]
		>=dev-libs/libgcrypt-1.4[static-libs]
		>=dev-libs/libgpg-error-1.7[static-libs]
		>=dev-libs/libksba-1.0.7[static-libs]
		>=dev-libs/pth-1.3.7[static-libs]
		>=net-misc/curl-7.10[static-libs]
		sys-libs/zlib[static-libs]
		bzip2? ( app-arch/bzip2[static-libs] )
	)
	nls? ( sys-devel/gettext )
	doc? ( sys-apps/texinfo )"

RDEPEND="!static? ( ${COMMON_DEPEND_LIBS} )
	${COMMON_DEPEND_BINS}
	!<=app-crypt/gnupg-2.0.1
	selinux? ( sec-policy/selinux-gpg )
	nls? ( virtual/libintl )"

REQUIRED_USE="smartcard? ( !static )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}/gnupg_master_0002-Fix-building-with-GNU-Automake-1.13.patch"
	epatch "${FILESDIR}/${PN}-2.0.17-gpgsm-gencert.patch"
#	epatch "${FILESDIR}/${PN}-2.1-hkps-schema.patch"
	epatch_user
	autoreconf || die "Autoreconf fail"
	./autogen.sh || die "Autgen script failed"
}

src_configure() {
	local myconf=()

	# 'USE=static' support was requested:
	# gnupg1: bug #29299
	# gnupg2: bug #159623
	use static && append-ldflags -static

	if use smartcard; then
		myconf+=(
			--enable-scdaemon
			$(use_enable usb ccid-driver)
		)
	else
		myconf+=( --disable-scdaemon )
	fi

	if use elibc_SunOS || use elibc_AIX; then
		myconf+=( --disable-symcryptrun )
	else
		myconf+=( --enable-symcryptrun )
	fi

	econf \
		--enable-maintainer-mode \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		--enable-gpg \
		--enable-gpgsm \
		--enable-agent \
		--without-adns \
		"${myconf[@]}" \
		$(use_enable bzip2) \
		$(use_enable gnutls) \
		$(use_with ldap) \
		$(use_enable nls) \
		$(use_with readline) \
		CC_FOR_BUILD="$(tc-getBUILD_CC)"
}

src_compile() {
	default

	if use doc; then
		cd doc
		emake html
	fi
}

src_install() {
	default

	use tools && dobin tools/{convert-from-106,gpg-check-pattern} \
		tools/{gpg-zip,gpgconf,gpgsplit,lspgpot,mail-signed-keys,make-dns-cert}

	emake DESTDIR="${D}" -f doc/Makefile uninstall-nobase_dist_docDATA
	rm "${ED}"/usr/share/gnupg/help* || die

	dodoc ChangeLog NEWS README THANKS TODO VERSION doc/FAQ doc/DETAILS \
		doc/HACKING doc/TRANSLATE doc/OpenPGP doc/KEYSERVER doc/help*

	dosym gpg2 /usr/bin/gpg
	dosym gpgv2 /usr/bin/gpgv
	echo ".so man1/gpg2.1" > "${ED}"/usr/share/man/man1/gpg.1
	echo ".so man1/gpgv2.1" > "${ED}"/usr/share/man/man1/gpgv.1

	dodir /etc/env.d
	echo "CONFIG_PROTECT=/usr/share/gnupg/qualified.txt" >> "${ED}"/etc/env.d/30gnupg

	if use doc; then
		dohtml doc/gnupg.html/* doc/*.png
	fi
}

pkg_postinst() {
	elog "If you wish to view images emerge:"
	elog "media-gfx/xloadimage, media-gfx/xli or any other viewer"
	elog "Remember to use photo-viewer option in configuration file to activate"
	elog "the right viewer."
	elog

	if use smartcard; then
		elog "To use your OpenPGP smartcard (or token) with GnuPG you need one of"
		use usb && elog " - a CCID-compatible reader, used directly through libusb;"
		elog " - sys-apps/pcsc-lite and a compatible reader device;"
		elog " - dev-libs/openct and a compatible reader device;"
		elog " - a reader device and drivers exporting either PC/SC or CT-API interfaces."
		elog ""
		elog "General hint: you probably want to try installing sys-apps/pcsc-lite and"
		elog "app-crypt/ccid first."
	fi

	ewarn "Please remember to restart gpg-agent if a different version"
	ewarn "of the agent is currently used. If you are unsure of the gpg"
	ewarn "agent you are using please run 'killall gpg-agent',"
	ewarn "and to start a fresh daemon just run 'gpg-agent --daemon'."

	if [[ -n ${REPLACING_VERSIONS} ]]; then
		elog "If upgrading from a version prior than 2.1 you will have to re-import"
		elog "secret keys after restarting the gpg-agent as the new version is using"
		elog "a new storage mechanism."
		elog "You can migrate the keys using gpg --import \$HOME/.gnupg/secring.gpg"
	fi
}
