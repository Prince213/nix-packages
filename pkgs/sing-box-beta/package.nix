{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.5-unstable-2026-02-23";

  src = previousAttrs.src.override {
    tag = null;
    rev = "94ed42caf1677293d249f9fb8c82c5284fddd0a8";
    hash = "sha256-yNZGUiNZh7fyW/BFgXcZg4ttnldRIDkB2KJ/MK5NH5E=";
  };

  vendorHash = "sha256-wBOu2Zac/PpUYKOxA5M56cyKdCLG2dQkBagKaGD8r4w=";
})
