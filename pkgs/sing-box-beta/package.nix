{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-beta.4";

  src = previousAttrs.src.override {
    hash = "sha256-fOOSP/Gqw65vb/bcU1ysgubBtXcuU8rxV2gzGUh77Z0=";
  };

  vendorHash = "sha256-CC6dKWj+9S9GxQ0vTuQOKFTZrVoJzOjP/OuWJ+SR8/0=";
})
