{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-beta.2";

  src = previousAttrs.src.override {
    hash = "sha256-VWMgm/Vw+TaL23Cm9wZ1Gw5GUtkyLSQFKLwl9bUwAkA=";
  };

  vendorHash = "sha256-qJiTmZ3J34/0oOziPitTSKGlh8FhPAMReUrd55W6VXU=";
})
