{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.22";

  src = previousAttrs.src.override {
    hash = "sha256-U7+UiflnmDOVBbvG49d6OHymcWOdo4CHAG6FmopTK5U=";
  };

  vendorHash = "sha256-DsURHNN0DBTqgn6VUaWYj2Wa+BQeMSwoEHLe1JROpao=";
})
