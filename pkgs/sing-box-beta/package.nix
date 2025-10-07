{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.20";

  src = previousAttrs.src.override {
    hash = "sha256-klB0i0qg4lkL/BrgcZQ6R8QEOs1LST6bmjDFOn9j88E=";
  };

  vendorHash = "sha256-MBaxyfEWShRB1w79SMNMLz2WOR4fBbIpfufctMQRF9Q=";
})
