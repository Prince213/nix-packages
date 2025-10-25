{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.26";

  src = previousAttrs.src.override {
    hash = "sha256-vE03cSs3IXrkb4kNKhwrZRfO0o3vB/I6oQCXTwMPFe4=";
  };

  vendorHash = "sha256-6Jvjk8VGwetbp9Ql0q7maYNKF+fXtejTxxdB/ARx7+k=";
})
