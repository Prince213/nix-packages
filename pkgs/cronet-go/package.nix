{
  apple-sdk_15,
  buildGoModule,
  buildPackages,
  darwin,
  fetchFromGitHub,
  gn,
  lib,
  ninja,
  python3,
  stdenvNoCC,
  symlinkJoin,
  xcbuild,
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
    version = "143.0.7499.109-1-unstable-2026-03-06";

    src = fetchFromGitHub {
      owner = "SagerNet";
      repo = "cronet-go";
      rev = "d181863d6a4aa2e7bb7eaf67c1d512c5e4827fde";
      fetchSubmodules = true;
      hash = "sha256-PG5+v7qynUT77cjsVWcGxmChb123ztOMT+IV42VOcPs=";
    };

    nativeBuildInputs = [
      buildPackages.rustc.llvmPackages.bintools
      ninja
      python3
    ]
    ++ lib.optional stdenvNoCC.hostPlatform.isDarwin xcbuild;

    buildInputs = lib.optional stdenvNoCC.hostPlatform.isDarwin apple-sdk_15;

    patches = lib.optional stdenvNoCC.hostPlatform.isDarwin ./libresolv.patch;
    postPatch = lib.optionalString stdenvNoCC.hostPlatform.isDarwin ''
      substituteInPlace naiveproxy/src/build/config/mac/BUILD.gn \
        --replace-fail @libresolv@ ${lib.getInclude darwin.libresolv}
    '';

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
      branch = "dev";
      homepage = "https://github.com/SagerNet/cronet-go";
      license = lib.licenses.gpl3Plus;
      maintainers = with lib.maintainers; [ prince213 ];
      platforms = lib.platforms.darwin ++ lib.platforms.linux;
    };
  }
)
