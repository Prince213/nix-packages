{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.6";

  src = previousAttrs.src.override {
    hash = "sha256-yNZGUiNZh7fyW/BFgXcZg4ttnldRIDkB2KJ/MK5NH5E=";
  };

  vendorHash = "sha256-wBOu2Zac/PpUYKOxA5M56cyKdCLG2dQkBagKaGD8r4w=";
})
