{
  cpio,
  fetchurl,
  lib,
  pbzx,
  sing-box-beta,
  stdenvNoCC,
  xar,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sing-box-app-beta";
  version = "1.13.0-rc.2";

  src = fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-Universal.pkg";
    hash = "sha256-Ufwn/6dZG04GDvsAZksUUUGWQpjcq7ZJJ5EzPNtdD7E=";
  };

  nativeBuildInputs = [
    cpio
    pbzx
    xar
  ];

  unpackPhase = ''
    runHook preUnpack

    xar -xf $src
    pbzx -n component-universal.pkg/Payload | cpio -i

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -a SFM.app $out/Applications

    runHook postInstall
  '';

  meta = sing-box-beta.meta // {
    platform = lib.platforms.darwin;
  };
})
