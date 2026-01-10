{
  cpio,
  fetchurl,
  gzip,
  lib,
  sing-box-beta,
  stdenvNoCC,
  xar,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sing-box-app-beta";
  version = "1.13.0-beta.2";

  src = fetchurl {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-Universal.pkg";
    hash = "sha256-WDFOFOTT30nMukNjHtAiKFpG2LGr9yUJ2f16rTnT6z8=";
  };

  nativeBuildInputs = [
    cpio
    gzip
    xar
  ];

  unpackPhase = ''
    runHook preUnpack

    xar -xf $src
    zcat component-universal.pkg/Payload | cpio -i

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
