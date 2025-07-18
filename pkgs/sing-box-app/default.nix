{
  fetchzip,
  lib,
  sing-box,
  stdenvNoCC,
  undmg,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sing-box-app";
  version = "1.11.15";

  src = fetchzip {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
    hash = "sha256-A2y4kE5LY4nTszOUQQ5JMyMcyypCD/i2grTXB3u6nsA=";
    stripRoot = false;
    nativeBuildInputs = [ undmg ];
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -a SFM.app $out/Applications

    runHook postInstall
  '';

  meta = sing-box.meta // {
    platform = lib.platforms.darwin;
  };
})
