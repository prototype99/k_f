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
    SRC_URI="http://archive.monkeysphere.info/xul-ext/monkeysphere.xpi"
fi


S=${WORKDIR}
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-crypt/msva-perl"
DEPEND="|| ( www-client/firefox-bin www-client/firefox ) app-arch/unzip"

src_unpack() {
	unzip -d "${S}" "${DISTDIR}/monkeysphere.xpi"
}

src_install(){
	local emid=$(sed -n 's/.*<em:id>\(.*\)<\/em:id>.*/\1/p' ${S}/install.rdf | head -1)
	mkdir -p "${D}/opt/firefox/extensions/${emid}"
	unzip -d "${D}/opt/firefox/extensions/${emid}" "${DISTDIR}/monkeysphere.xpi"
}
