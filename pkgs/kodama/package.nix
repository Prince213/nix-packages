{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kodama";
  version = "0.3.7-rc";

  src = fetchFromGitHub {
    owner = "kokic";
    repo = "kodama";
    tag = "v${finalAttrs.version}";
    hash = "sha256-Oncr3bz+NX+FJWke2W2WOQSBDTwTlzK0F8CFeS4hXyE=";
  };

  cargoHash = "sha256-IkF0tG1nWEKEZh4cWVHrw4D4bHR1Bs4FafVG5sPe1Qc=";

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
