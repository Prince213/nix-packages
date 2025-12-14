{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.28";

  src = previousAttrs.src.override {
    hash = "sha256-vxojLIAz8OlI/qr1E+sr+mag2CAJ2k8C5Bwi9dqpKYc=";
  };

  vendorHash = "sha256-AMsyZWuX9fCz121DdqL+r0D2P9iAXhA+Slm27o4wLis=";
})
