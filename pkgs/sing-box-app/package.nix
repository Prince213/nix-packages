{
  fetchzip,
  lib,
  sing-box,
  stdenvNoCC,
  undmg,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sing-box-app";
  version = "1.12.8";

  src = fetchzip {
    url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
    hash = "sha256-feoue0FLbn5Xo0asxl/azols9iR8IcrZu1GJo4nDRqQ=";
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
