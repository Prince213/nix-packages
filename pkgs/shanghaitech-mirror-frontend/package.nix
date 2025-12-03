{
  bun,
  fetchFromGitHub,
  lib,
  nodejs,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (
  finalAttrs:
  let
    inherit (stdenvNoCC.hostPlatform) system;
    bunDeps = stdenvNoCC.mkDerivation {
      name = "${finalAttrs.pname}-bun-deps";

      inherit (finalAttrs) src;

      nativeBuildInputs = [ bun ];

      buildPhase = ''
        runHook preBuild

        export BUN_INSTALL_CACHE_DIR=$(mktemp -d)

        bun install --production --no-save --frozen-lockfile --no-progress

        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -R node_modules $out/

        runHook postInstall
      '';

      outputHash = finalAttrs.passthru.bunDepsHashes.${system} or (throw "Unsupported system: ${system}");
      outputHashAlgo = "sha256";
      outputHashMode = "recursive";
    };
  in
  {
    pname = "shanghaitech-mirror-frontend";
    version = "0-unstable-2025-10-30";

    src = fetchFromGitHub {
      owner = "ShanghaitechGeekPie";
      repo = "shanghaitech-mirror-frontend";
      rev = "174a0c1fe6b21f63f4a68b569aebf43ec55125fc";
      hash = "sha256-JOm1ZVgdXR/SAvX+CnswIMTCQYdQ1U5OZEzC1l4jwk8=";
    };

    nativeBuildInputs = [ bun ];

    postConfigure = ''
      cp -R ${bunDeps}/node_modules .
      substituteInPlace node_modules/.bin/{tsc,vite} \
        --replace-fail "/usr/bin/env node" "${nodejs}/bin/node"
    '';

    buildPhase = ''
      runHook preBuild

      bun run --prefer-offline build

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      cp -R dist $out

      runHook postInstall
    '';

    passthru = {
      bunDepsHashes = {
        aarch64-darwin = "sha256-jWXfTORlyowx82EKkU3krNLUpUFdX00vMfiTIfS+cCE=";
        aarch64-linux = "sha256-qoqV/gEvIrJxiwbiRDNIUI2fq5ds/s8M+1N+Jv4+1bk=";
        x86_64-darwin = "sha256-mRUoWBIuqdHBlJWNE3+BPpSUh8oC+pUIDs1q2dlf5M8=";
        x86_64-linux = "sha256-M53Lh0VjPd/C3RqO87ZxBvfhuouB4np6m8M6jEpEYV8=";
      };
    };

    meta = {
      description = "Frontend of the ShanghaiTech Open Source Mirror";
      homepage = "https://github.com/ShanghaitechGeekPie/shanghaitech-mirror-frontend";
      # https://github.com/zTrix/sata-license
      license = lib.licenses.mit;
      maintainers = with lib.maintainers; [ prince213 ];
      platforms = lib.attrNames finalAttrs.passthru.bunDepsHashes;
    };
  }
)
