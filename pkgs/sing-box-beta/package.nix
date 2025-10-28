{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.27";

  src = previousAttrs.src.override {
    hash = "sha256-0iKUTfSX4oijjl3AQb4k5voWII3y3adYw6yYpd+Qdd8=";
  };

  vendorHash = "sha256-OxhwP7uYXpnPFkZBFKw+4fw+gkufHNAUV3xZ4VFj2yQ=";
})
