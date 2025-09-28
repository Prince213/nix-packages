{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kodama";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner = "kokic";
    repo = "kodama";
    tag = "v${finalAttrs.version}";
    hash = "sha256-duzvvNbxSmqddX3K+ICDCejrXZaF4v4kVowZUtRPjJA=";
  };

  cargoHash = "sha256-GKwD/f2oEq01g99JmYXQpLpxz5UsvB91fh/zrxNIuMs=";

  meta = {
    description = "Typst-friendly static Zettelkästen site generator";
    homepage = "https://github.com/kokic/kodama";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ prince213 ];
  };
})
