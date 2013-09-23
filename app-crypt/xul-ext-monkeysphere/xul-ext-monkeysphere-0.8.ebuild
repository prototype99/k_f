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
    SRC_URI="http://archive.monkeysphere.info/debian/pool/monkeysphere/x/xul-ext-monkeysphere/${PN}_${PV}.orig.tar.gz"
fi


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-crypt/msva-perl"
DEPEND="|| ( www-client/firefox-bin www-client/firefox ) app-arch/unzip media-gfx/inkscape"

src_install(){
	local emid=$(sed -n 's/.*<em:id>\(.*\)<\/em:id>.*/\1/p' ${S}/install.rdf | head -1)
	local cleanup="Makefile install.rdf.template monkeysphere.xpi"
	for i in $cleanup; do rm ${S}/$i; done; 
	mkdir -p "${D}/opt/firefox/extensions/${emid}"
	cp -r ${S}/* "${D}/opt/firefox/extensions/${emid}/"
}
