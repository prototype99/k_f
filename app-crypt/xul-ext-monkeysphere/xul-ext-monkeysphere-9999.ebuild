EAPI=5

inherit base eutils

DESCRIPTION="Iceweasel/Firefox extension for using Monkeysphere on the web"
HOMEPAGE="http://web.monkeysphere.info/"

if [[ ${PV} == "9999" ]] ; then
    inherit git-2
    EGIT_BRANCH="master"
    EGIT_REPO_URI="git://git.monkeysphere.info/${PN}"
    SRC_URI=""
else
    MY_P="${PN}_${PV}"
    SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/m/${PN}/${MY_P}.orig.tar.gz"
fi


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-crypt/msva-perl"
DEPEND="dev-vcs/git"
S="${WORKDIR}"

src_prepare() {
	unpack monkeysphere.xpi
}

src_compile() {
	pushd libufe-xidgetter/
		emake || die
	popd

	pushd unity-firefox-extension/
		bash ./build.sh || die
	popd
}

src_install() {
	pushd libufe-xidgetter/
		emake DESTDIR="${D}" install
	popd

	pushd unity-firefox-extension/
		local emid=$(sed -n 's/.*<em:id>\(.*\)<\/em:id>.*/\1/p' install.rdf | head -1)
		dodir usr/lib/firefox/browser/extensions/${emid}/
		unzip unity.xpi -d \
			"${D}usr/lib/firefox/browser/extensions/${emid}/" || die
	popd
	dosym /usr/lib/firefox/browser/extensions/${emid} /opt/firefox/browser/extensions/${emid}

	prune_libtool_files --modules
}
