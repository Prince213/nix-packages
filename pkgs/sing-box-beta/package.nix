{
  cronet-go,
  go,
  lib,
  sing-box,
  stdenvNoCC,

  withNaiveOutbound ? false,
}:

sing-box.overrideAttrs (
  previousAttrs:
  {
    pname = previousAttrs.pname + "-beta";
    version = "1.13.0-rc.6";

    src = previousAttrs.src.override {
      hash = "sha256-yNZGUiNZh7fyW/BFgXcZg4ttnldRIDkB2KJ/MK5NH5E=";
    };

    vendorHash = "sha256-wBOu2Zac/PpUYKOxA5M56cyKdCLG2dQkBagKaGD8r4w=";
  }
  // lib.optionalAttrs (withNaiveOutbound && stdenvNoCC.hostPlatform.isDarwin) {
    buildInputs = (previousAttrs.buildInputs or [ ]) ++ [ cronet-go ];
    tags = previousAttrs.tags ++ lib.optional withNaiveOutbound "with_naive_outbound";
  }
  // lib.optionalAttrs (withNaiveOutbound && stdenvNoCC.hostPlatform.isLinux) {
    modPostBuild = (previousAttrs.modPostBuild or "") + ''
      cd vendor/github.com/sagernet/cronet-go
      patch -p1 < ${./cronet-go.patch}
      cd ../../../..
    '';

    vendorHash = "sha256-cxsUOMBuRFViUSQiDd2gQ7nzk+g4B908NTsAr4x7jtk=";

    tags =
      previousAttrs.tags
      ++ lib.optionals withNaiveOutbound [
        "with_purego"
        "with_naive_outbound"
      ];

    postInstall =
      previousAttrs.postInstall
      + lib.optionalString withNaiveOutbound ''
        ln -s "${cronet-go}/lib/${go.GOOS}_${go.GOARCH}/libcronet.so" "$out/lib/"
      '';
  }
)
