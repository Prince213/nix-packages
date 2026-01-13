{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-beta.5";

  src = previousAttrs.src.override {
    hash = "sha256-qs3ghFm5Q5ahvgZGqimRr2jRYTPdEJ1P7BLert28gUs=";
  };

  vendorHash = "sha256-qYODIrLHx7hs1BTl+tnAovCsloArzicHdutg7Xzc5vQ=";
})
