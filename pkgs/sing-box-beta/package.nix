{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.35";

  src = previousAttrs.src.override {
    hash = "sha256-F0vHAdCScDV5eFxGYANy58mLlmnTeEq9bkVmkm3wk/s=";
  };

  vendorHash = "sha256-SULC+YHgQ4l+UPiP1JUTeyrG3stxJh0ucwC+vmlX67I=";
})
