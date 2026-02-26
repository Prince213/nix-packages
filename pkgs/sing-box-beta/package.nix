{
  cronet-go,
  go,
  lib,
  sing-box,
  stdenvNoCC,

  withNaiveOutbound ? false,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.6";

  src = previousAttrs.src.override {
    hash = "sha256-yNZGUiNZh7fyW/BFgXcZg4ttnldRIDkB2KJ/MK5NH5E=";
  };

  vendorHash = "sha256-wBOu2Zac/PpUYKOxA5M56cyKdCLG2dQkBagKaGD8r4w=";

  preBuild = (previousAttrs.preBuild or "") + ''
    cd vendor/github.com/sagernet/cronet-go
    chmod -R u+w .
    cp -r ${cronet-go}/ .
    ${lib.optionalString (
      withNaiveOutbound && stdenvNoCC.hostPlatform.isLinux
    ) "patch -p1 < ${./cronet-go.patch}"}
    cd ../../../..
  '';

  buildInputs =
    (previousAttrs.buildInputs or [ ])
    ++ lib.optional (withNaiveOutbound && stdenvNoCC.hostPlatform.isDarwin) cronet-go;

  tags =
    previousAttrs.tags
    ++ lib.optional withNaiveOutbound "with_naive_outbound"
    ++ lib.optional (withNaiveOutbound && stdenvNoCC.hostPlatform.isLinux) "with_purego";

  postInstall =
    previousAttrs.postInstall
    + lib.optionalString (withNaiveOutbound && stdenvNoCC.hostPlatform.isLinux) ''
      ln -s "${cronet-go}/lib/${go.GOOS}_${go.GOARCH}/libcronet.so" "$out/lib/"
    '';
})
