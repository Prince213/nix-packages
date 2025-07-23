{
  fetchzip,
  sing-box-app,
  sing-box-beta,
  undmg,
}:

(sing-box-app.override { sing-box = sing-box-beta; }).overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.12.0-rc.2";

    src = fetchzip {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
      hash = "sha256-tmdmwYNgd5ua6wF5Rd9vTT0LoWbAm1RrNpTb0bWyiQc=";
      stripRoot = false;
      nativeBuildInputs = [ undmg ];
    };
  }
)
