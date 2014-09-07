# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sks/sks-1.1.4-r1.ebuild,v 1.2 2013/12/13 09:29:03 patrick Exp $

EAPI=5

inherit rpm user udev

DESCRIPTION="PicoScope is the standard in PC Oscilloscope software"
HOMEPAGE="http://www.picotech.com/picoscope-oscilloscope-software.html"
MY_V=(${PV//./ })
MY_PV=${MY_V[0]}"."${MY_V[1]}"."${MY_V[2]}"-"${MY_V[3]}"r"${MY_V[4]}
SRC_URI="http://labs.picotech.com/rpm/noarch/picoscope-${MY_PV}.noarch.rpm"
LICENSE="PICO"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND=""
DEPEND="${CDEPEND}"
RDEPEND="
	dev-lang/mono
	dev-dotnet/atk-sharp
	dev-dotnet/gdk-sharp
	dev-dotnet/glib-sharp
	dev-dotnet/gtk-dotnet-sharp
	dev-dotnet/gtk-sharp
	dev-libs/libusb
	dev-libs/picoipp
	dev-libs/usbdrdaq
	dev-libs/plcm3
	dev-libs/usbpt104
	${CDEPEND}"

S="${WORKDIR}/"

pkg_setup() 
{
	ebegin "Creating named group"
	enewgroup pico
}

pkg_postinst() {
	elog "Please note that you will have to install the corresponding driver"
	elog "for your device. Consult dev-libs/psXXXX packages corresponding"
	elog "to your device"
	elog "Note that you have to be either root or member of the group pico to"
	elog "be able to use picoscope devices."
}

src_unpack()
{
    rpm_src_unpack ${A}
}

src_install()
{
	insinto "/opt"
	doins -r opt/*
	fperms 755 "/opt/picoscope/bin/picoscope"
	udev_dorules "${FILESDIR}/95-pico.rules"
	domenu "${FILESDIR}/picoscope.desktop"
}
