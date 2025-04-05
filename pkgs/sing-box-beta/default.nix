{ sing-box }:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.1";
  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-I6fFt1GZsrHl302wbxwKGyBbwvAgUA9cEpxnLWdN5Vs=";
  };
  vendorHash = "sha256-fiNv3hdasa/t/v0F5Tsifnk0unMv/p0cudE3sSF6rLs=";
  ldflags = [
    "-X=github.com/sagernet/sing-box/constant.Version=${version}"
  ];
})
