{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.29";

  src = previousAttrs.src.override {
    hash = "sha256-N1XChLsG5wPQ3qe2mNYsGCP9Hd1LmEV6CLHKWGr7L3A=";
  };

  vendorHash = "sha256-H+btTIhutD7tTE5dzynR1DxslKRFVo6PclWBi3inTuo=";
})
