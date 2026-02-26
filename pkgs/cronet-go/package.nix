{
  buildGoModule,
  buildPackages,
  fetchFromGitHub,
  gn,
  lib,
  ninja,
  python3,
  stdenvNoCC,
  symlinkJoin,
}:
let
  llvmCcAndBintools = symlinkJoin {
    name = "llvmCcAndBintools";
    paths = [
      buildPackages.rustc.llvmPackages.llvm
      buildPackages.rustc.llvmPackages.stdenv.cc
    ];
  };
in
stdenvNoCC.mkDerivation (
  finalAttrs:
  let
    build-naive = buildGoModule {
      pname = finalAttrs.pname + "-build-naive";
      inherit (finalAttrs) version src;
      vendorHash = "sha256-tVIKTznnducPfATK151TpC3UV2U852TyclBTSgh/H6U=";
      patches = [ ./build-naive.patch ];
      postPatch = ''
        substituteInPlace cmd/build-naive/cmd_build.go \
          --replace-fail @gn@ ${lib.getExe gn} \
          --replace-fail @clang_base_path@ ${llvmCcAndBintools}
      '';
      subPackages = [ "cmd/build-naive" ];
      meta.mainProgram = "build-naive";
    };
  in
  {
    pname = "cronet-go";
    version = "143.0.7499.109-1-unstable-2026-02-26";

    src = fetchFromGitHub {
      owner = "SagerNet";
      repo = "cronet-go";
      rev = "f06e53acecf6d2a7fd1199b6e343014403dd7b4c";
      fetchSubmodules = true;
      hash = "sha256-1MUh3ikQEAMjEqPiPE23KAKoMyMq5Eq28AswY8MYXVQ=";
    };

    nativeBuildInputs = [
      buildPackages.rustc.llvmPackages.bintools
      ninja
      python3
    ];

    buildPhase = ''
      runHook preBuild

      ${lib.getExe build-naive} build
      ${lib.getExe build-naive} package --local
      ${lib.getExe build-naive} package

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out
      cp -r lib include include_cgo.go $out/

      runHook postInstall
    '';

    meta = {
      description = "Go bindings for naiveproxy";
      homepage = "https://github.com/SagerNet/cronet-go";
      license = lib.licenses.gpl3Plus;
      maintainers = with lib.maintainers; [ prince213 ];
      platforms = with lib.platforms; darwin ++ linux;
    };
  }
)
