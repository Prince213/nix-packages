{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kodama";
  version = "0.4.0-rc";

  src = fetchFromGitHub {
    owner = "kokic";
    repo = "kodama";
    tag = "v${finalAttrs.version}";
    hash = "sha256-F5m2DrUFo2tN8hpMJRM0MZe7tk2Sif3u9b67lYmyXxk=";
  };

  cargoHash = "sha256-s7TAP0GHlRY7RAcUhm++TGKwfbaRCIuSySXdNnL/bFM=";

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
