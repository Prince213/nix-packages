{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kodama";
  version = "0.3.0-unstable-2025-07-30";

  src = fetchFromGitHub {
    owner = "kokic";
    repo = "kodama";
    rev = "8ef2d5c105d31f02499d3b633ad3085de203824e";
    hash = "sha256-RrHzOy3NLEsEGLVTyUYIWWITFxcxk4NaNxzdynjX6QQ=";
  };

  cargoHash = "sha256-GKwD/f2oEq01g99JmYXQpLpxz5UsvB91fh/zrxNIuMs=";

  meta = {
    description = "Typst-friendly static Zettelkästen site generator";
    homepage = "https://github.com/kokic/kodama";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ prince213 ];
  };
})
