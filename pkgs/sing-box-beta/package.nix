{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.1";

  src = previousAttrs.src.override {
    hash = "sha256-BvisqHPGZtRsehpz5OBKbnHUI+RO22PEvd/BM604LG4=";
  };

  vendorHash = "sha256-+2uCNH656h+Cq3DCBfWuFCp5G16T05h9k1TXqkixzno=";
})
