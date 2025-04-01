{ sing-box, ... }:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-alpha.23";
  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-3Fe7XuO9NVR6Ry/a+jERE8fcz+glbOxHUpU8ApZJrUc=";
  };
  vendorHash = "sha256-s3kHLfOsYqJW4rQsNHbd2mWjvrrA0w/CbtjaaqiYoGw=";
  ldflags = [
    "-X=github.com/sagernet/sing-box/constant.Version=${version}"
  ];
})
