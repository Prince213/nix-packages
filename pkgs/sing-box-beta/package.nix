{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.32";

  src = previousAttrs.src.override {
    hash = "sha256-Hz+8/Xoxb/SLG6yMe27PiRwyHwjLDCw6gU6K+eXg37I=";
  };

  vendorHash = "sha256-XIYvyDmOtE4l4toEzsghWyrfdYL+N3Jx7jibbnr+GO0=";
})
