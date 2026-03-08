{
  fetchurl,
  lib,
  sing-box-app,
  sing-box-beta,
}:

sing-box-app.overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.14.0-alpha.1";

    src = fetchurl {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-Universal.pkg";
      hash = "sha256-f/GD4zMOKWqZZr5tg2HFzRkblQ8dxqoXOh6fZ1uw264=";
    };

    meta = sing-box-beta.meta // {
      platform = lib.platforms.darwin;
    };
  }
)
