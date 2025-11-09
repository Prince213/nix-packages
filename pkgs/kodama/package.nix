{
  lib,
  fetchFromGitHub,
  fetchpatch2,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "kodama";
  version = "0.3.3-patch";

  src = fetchFromGitHub {
    owner = "kokic";
    repo = "kodama";
    tag = "v${finalAttrs.version}";
    hash = "sha256-evYgMWza0SNZSoiQtoaeVeh/pCwNq5QbeCXcBZrUdx8=";
  };

  patches = [
    # https://github.com/kokic/kodama/pull/84
    (fetchpatch2 {
      url = "https://github.com/Prince213/kodama/commit/7e78bb0369311c1a1de4787f7a0dda5e0544c0da.patch?full_index=1";
      hash = "sha256-wt470eIn9vF+BemJSRuu6B8IaTymNnoVsM4vWs+1lro=";
    })
  ];

  cargoHash = "sha256-NhHTnzBVJvlbyf0okv2V8a9prv4cIcmAAJUEsss6Yk8=";

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
