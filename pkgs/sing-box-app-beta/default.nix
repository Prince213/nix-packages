{
  fetchzip,
  sing-box-app,
  sing-box-beta,
  undmg,
}:

(sing-box-app.override { sing-box = sing-box-beta; }).overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.12.0-beta.28";

    src = fetchzip {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
      hash = "sha256-I2wV3Y8qjclBRD+PN254B45xveLItiFO2YKX1iM1/n0=";
      stripRoot = false;
      nativeBuildInputs = [ undmg ];
    };
  }
)
