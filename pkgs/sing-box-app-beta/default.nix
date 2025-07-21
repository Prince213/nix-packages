{
  fetchzip,
  sing-box-app,
  sing-box-beta,
  undmg,
}:

(sing-box-app.override { sing-box = sing-box-beta; }).overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.12.0-beta.35";

    src = fetchzip {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-universal.dmg";
      hash = "sha256-0qzuDGzgaS0IRDivPxLIepg1focHLy+QE4b2uRyWF4A=";
      stripRoot = false;
      nativeBuildInputs = [ undmg ];
    };
  }
)
