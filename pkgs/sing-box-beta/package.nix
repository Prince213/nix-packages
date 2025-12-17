{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.30";

  src = previousAttrs.src.override {
    hash = "sha256-itKsB+D+ahhNdw56pqCXpjknvJdnrd9IBaElG2MdhL4=";
  };

  vendorHash = "sha256-ZRtRJq1a9sSAmx+mt7MfVvNjsLrf3NMsUOQxO4SVMY8=";
})
