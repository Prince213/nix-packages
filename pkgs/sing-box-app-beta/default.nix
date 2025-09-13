{
  fetchzip,
  sing-box-app,
  sing-box-beta,
  undmg,
}:

(sing-box-app.override { sing-box = sing-box-beta; }).overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.13.0-alpha.14";

    src = fetchzip {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
      hash = "sha256-0uhUs2yaUvQUi5vj/tY39LMO/2V3vVKiZr/kmeuP/SY=";
      stripRoot = false;
      nativeBuildInputs = [ undmg ];
    };
  }
)
