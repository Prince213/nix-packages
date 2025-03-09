{ sing-box, ... }:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-alpha.13";
  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-bMG6Kn+s7v+hWLMoo5T1m9hnqdNJ/w4Iqcj+w8r4Rn8=";
  };
  vendorHash = "sha256-SLTrWUl73B/rqfEppM/O3LchEc/bHifAbvY+cM7d7dc=";
  ldflags = [
    "-X=github.com/sagernet/sing-box/constant.Version=${version}"
  ];
})
