{ dae, ... }:

dae.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "dae-beta";
  version = "1.0.0rc2";
  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-vNOmLKBClxTUs1gw9dxAZyCZcM8cr4Pz24E1QEJvzLI=";
  };
  vendorHash = "sha256-HLBvvCwa6AxhR/Y30hyymNIStYsUbIHY0eQBe2/IiOI=";
})
