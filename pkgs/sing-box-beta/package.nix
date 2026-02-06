{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.2";

  src = previousAttrs.src.override {
    hash = "sha256-v/b0NO29JkSf2TfwIwg7XMCoQjXm9U/i5EA9o/NLaZ8=";
  };

  vendorHash = "sha256-Qj2+1Lht6lEEC1ve/hTZiE/NhJwf0KKiFqr1FfDxjsQ=";
})
