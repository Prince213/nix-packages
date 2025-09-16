{
  fetchzip,
  sing-box-app,
  sing-box-beta,
  undmg,
}:

(sing-box-app.override { sing-box = sing-box-beta; }).overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.13.0-alpha.15";

    src = fetchzip {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
      hash = "sha256-gb/U7ap0UJJuRHf6uVmOquWWWbVOgV6g/2swzrb16hs=";
      stripRoot = false;
      nativeBuildInputs = [ undmg ];
    };
  }
)
