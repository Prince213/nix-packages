{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.31";

  src = previousAttrs.src.override {
    hash = "sha256-k8wPfbajSfZMC1y7fjIm7t/v0HzRB1FVcvSe+9Mme+s=";
  };

  vendorHash = "sha256-nITtMrNAQlaw7W2V9aXtZYBDZeC8iZ/4PkBWLR0WVDQ=";
})
