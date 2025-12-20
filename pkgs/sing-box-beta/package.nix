{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.33";

  src = previousAttrs.src.override {
    hash = "sha256-7LSBo2ZbzB0GsXJtIl8L1aCbrBGQg0UL7+yjiw0/KCc=";
  };

  vendorHash = "sha256-8PheEP6nEs1dMCCzA+UtzCbtuyAaWhrrv+zgh9Pse44=";
})
