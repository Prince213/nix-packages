{
  fetchzip,
  sing-box-app,
  sing-box-beta,
  undmg,
}:

(sing-box-app.override { sing-box = sing-box-beta; }).overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.13.0-alpha.22";

    src = fetchzip {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
      hash = "sha256-UmON/Ho6Abpa15kzU6+hY8Hum5WkuzPeqLrUHF5io7c=";
      stripRoot = false;
      nativeBuildInputs = [ undmg ];
    };
  }
)
