{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.36";

  src = previousAttrs.src.override {
    hash = "sha256-RVthYVPJOxSlxrsBeJ0bXUmohb30lWDo+HKcWNLgHeg=";
  };

  vendorHash = "sha256-fMcpUkAhDulY4leADaQ0mGey0+D0KiMP4TRbKWge5Y0=";
})
