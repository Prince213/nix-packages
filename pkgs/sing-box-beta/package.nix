{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.34";

  src = previousAttrs.src.override {
    hash = "sha256-R74Eio+o21zbTPvmROCduiK4ZQKBiv6OPoBsxLOQUqE=";
  };

  vendorHash = "sha256-TiuVCkrB+Op68HVzqhd1Bhwtc1lKo1swyx+RblAR/os=";
})
