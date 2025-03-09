{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  p7zip,
  ...
}:

stdenvNoCC.mkDerivation {
  pname = "wubi98-fonts";
  version = "2024-01-31";

  src = fetchFromGitHub {
    owner = "yanhuacuo";
    repo = "fcitx5-wubi98";
    rev = "1001410331a731f39b32bc8786d8a22e9f0b68ab";
    hash = "sha256-leJlhmt/oFDrdMTGscbb7CMpWORyCZ221xSpxm4ydHU=";
  };

  nativeBuildInputs = [
    p7zip
  ];

  buildPhase = ''
    7z x fcitx5-rime.7z.001
  '';

  installPhase = ''
    install -Dm 444 -t $out/share/fonts/opentype/wubi98-fonts fcitx5-rime/fonts/98WB-[0123UV].otf
  '';

  meta = {
    description = "Fonts for wubi98";
    license = lib.licenses.unlicense;
    platforms = lib.platforms.all;
  };
}
