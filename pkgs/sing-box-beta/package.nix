{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.21";

  src = previousAttrs.src.override {
    hash = "sha256-SxIytB9jTF4s3cifv0bQaNWxMCZUH5Z70TaSnJXji8E=";
  };

  vendorHash = "sha256-MBaxyfEWShRB1w79SMNMLz2WOR4fBbIpfufctMQRF9Q=";
})
