{
  fetchurl,
  lib,
  sing-box-app,
  sing-box-beta,
}:

sing-box-app.overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.14.0-alpha.2";

    src = fetchurl {
      url = "https://github.com/SagerNet/sing-box/releases/download/v${finalAttrs.version}/SFM-${finalAttrs.version}-Universal.pkg";
      hash = "sha256-NDj6ZTONzK3hbqI85rFqbPF7BELNyNUJt5Zkwrmm75M=";
    };

    meta = sing-box-beta.meta // {
      platform = lib.platforms.darwin;
    };
  }
)
