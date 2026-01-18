{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-beta.7";

  src = previousAttrs.src.override {
    hash = "sha256-TCCssZfBMPNsADigFE+ckpCmh5tggdoQPTTI6eKQ1v4=";
  };

  vendorHash = "sha256-pvAhL/h5+6BDtrhNCu3Rp40NXzsdQ4Xan46aCPr3jm0=";
})
