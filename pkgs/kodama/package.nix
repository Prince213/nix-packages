{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kodama";
  version = "0.4.2";

  src = fetchFromGitHub {
    owner = "kokic";
    repo = "kodama";
    tag = "v${finalAttrs.version}";
    hash = "sha256-IT5zgWID0p5+4uSZpvDfIgmgmNk57DRw73vWKCqRt1Y=";
  };

  cargoHash = "sha256-qeY3WunQhD6wyS+x3BpMxZXWdB2BJ1GCOI4BCEUgq8s=";

  checkFlags = [
    "--skip=process::embed_markdown::tests::test_is_assets_file"
  ];

  meta = {
    description = "Typst-friendly static Zettelkästen site generator";
    homepage = "https://github.com/kokic/kodama";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ prince213 ];
  };
})
