{
  buildPackages,
  cronet-go,
  go,
  lib,
  sing-box,
  stdenvNoCC,

  withStaticCronet ? true,
  withNaiveOutbound ? false,
}:
assert withNaiveOutbound -> !withStaticCronet -> stdenvNoCC.hostPlatform.isLinux;
sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.1-beta.1";

  src = previousAttrs.src.override {
    hash = "sha256-cpRaFnb7hSMnLWQh84zXpMUBVc+k2KH7wDPE9C1tv40=";
  };

  vendorHash = "sha256-9+OkitjuHiXwEPtGUVQ12FpNPnLm89jUKj1M8Z4gL1s=";

  preBuild =
    (previousAttrs.preBuild or "")
    + lib.optionalString withNaiveOutbound ''
      cd vendor/github.com/sagernet/cronet-go
      chmod -R u+w .
      cp -r ${cronet-go}/ .
      ${lib.optionalString (!withStaticCronet) "patch -p1 < ${./cronet-go.patch}"}
      cd ../../../..
    '';

  nativeBuildInputs =
    previousAttrs.nativeBuildInputs
    ++ lib.optional (withNaiveOutbound && withStaticCronet) buildPackages.rustc.llvmPackages.bintools;

  buildInputs =
    (previousAttrs.buildInputs or [ ])
    ++ lib.optional (withNaiveOutbound && withStaticCronet) cronet-go;

  tags =
    previousAttrs.tags
    ++ lib.optionals withNaiveOutbound (
      [ "with_naive_outbound" ] ++ lib.optional (!withStaticCronet) "with_purego"
    );

  postInstall =
    previousAttrs.postInstall
    + lib.optionalString (withNaiveOutbound && !withStaticCronet) ''
      ln -s "${cronet-go}/lib/${go.GOOS}_${go.GOARCH}/libcronet.so" "$out/lib/"
    '';

  env =
    previousAttrs.env
    // lib.optionalAttrs (withNaiveOutbound && withStaticCronet) {
      CGO_ENABLED = 1;
      CGO_LDFLAGS = "-fuse-ld=lld";
    };
})
