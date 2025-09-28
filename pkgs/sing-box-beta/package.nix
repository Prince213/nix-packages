{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-alpha.8";

  src = previousAttrs.src.override {
    hash = "sha256-4LtLeh+1fiCAwgHZK48YMHJOivFj3OGJUpWdlpK7PFE=";
  };

  vendorHash = "sha256-vzjM7jOiOGyY+ucDABzWWo5a+W1+msnHsdMxHi7yb1A=";
})
