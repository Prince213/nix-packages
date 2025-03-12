{
  autoconf,
  automake,
  docbook-xsl-nons,
  docbook_xml_dtd_42,
  fetchFromGitHub,
  glib,
  gobject-introspection,
  intltool,
  ipset,
  iptables,
  kdePackages,
  kmod,
  lib,
  libnotify,
  libxml2,
  libxslt,
  networkmanager,
  pkg-config,
  python3,
  qt6,
  stdenv,
  sysctl,
  wrapGAppsHook3,
}:

let
  python3' = python3.withPackages (
    ps: with ps; [
      dbus-python
      nftables
      pygobject3
      pyqt6
    ]
  );
in
stdenv.mkDerivation rec {
  pname = "firewalld";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "firewalld";
    repo = "firewalld";
    rev = "v${version}";
    hash = "sha256-ubE1zMIOcdg2+mgXsk6brCZxS1XkvJYwVY3E+UXIIiU=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    docbook-xsl-nons
    docbook_xml_dtd_42
    intltool
    ipset
    iptables
    kmod
    qt6.wrapQtAppsHook
    libxml2
    libxslt
    pkg-config
    python3'
    python3'.pkgs.wrapPython
    sysctl
    wrapGAppsHook3
  ];

  buildInputs = [
    glib
    gobject-introspection
    ipset
    iptables
    kmod
    libnotify
    networkmanager
    python3'
    qt6.qtbase
    sysctl
  ];

  patches = [
    ./respect-xml-catalog-files-var.patch
    ./specify-localedir.patch
  ];

  postPatch = ''
    for file in config/firewall-{applet,config}.desktop.in \
      doc/xml/{firewalld.xml.in,firewalld.dbus.xml,firewall-offline-cmd.xml} \
      src/{firewall-offline-cmd.in,firewall/config/__init__.py.in}
    do
      substituteInPlace $file --replace-fail /usr "$out"
    done

    substituteInPlace src/firewall-applet.in \
      --replace-fail /usr "${kdePackages.systemsettings}"
  '';

  preConfigure = ''
    ./autogen.sh
  '';

  dontWrapGApps = true;
  dontWrapQtApps = true;

  preFixup = ''
    makeWrapperArgs+=("''${gappsWrapperArgs[@]}")
    makeWrapperArgs+=("''${qtWrapperArgs[@]}")
  '';

  postFixup = ''
    wrapPythonPrograms
  '';

  meta = {
    description = "Stateful zone based firewall daemon with D-Bus interface";
    homepage = "https://firewalld.org/";
    downloadPage = "https://github.com/firewalld/firewalld/releases";
    license = lib.licenses.gpl2Plus;
    sourceProvenance = [ lib.sourceTypes.fromSource ];
    platforms = lib.platforms.linux;
  };
}
