{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.5";

  src = previousAttrs.src.override {
    hash = "sha256-NzwVKgeNJik9CAMWvxI5c+dm6WLkkV0YCiQ6liy+pjE=";
  };

  vendorHash = "sha256-YijaIpsqT7/03cmpt85WlzLNgEApZVdZm4T9Mn1OpeA=";
})
