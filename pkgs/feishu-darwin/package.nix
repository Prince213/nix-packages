{
  feishu,
  fetchurl,
  lib,
  stdenvNoCC,
  undmg,
}:

let
  inherit (stdenvNoCC.hostPlatform) system;

  sources =
    let
      base = "https://sf3-cn.feishucdn.com/obj";
    in
    {
      # curl 'https://www.feishu.cn/api/package_info?platform=9'
      aarch64-darwin = {
        version = "7.57.6";
        src = fetchurl {
          url = "${base}/ee-appcenter/38dbda33/Feishu-darwin_arm64-7.57.6-signed.dmg";
          hash = "sha256-3CE+k6E0oyRkFMppLqh/8J8ksb6mzEMfuZRu06R2G3c=";
        };
      };
      # curl 'https://www.feishu.cn/api/package_info?platform=6'
      x86_64-darwin = {
        version = "7.57.6";
        src = fetchurl {
          url = "${base}/ee-appcenter/b27bf937/Feishu-darwin_x64-7.57.6-signed.dmg";
          hash = "sha256-V0TjQN2aDu62UY/s7B1hSXkiT3gMqjkr4xZL1JhkQA0=";
        };
      };
    };
in
stdenvNoCC.mkDerivation (finalAttrs: {
  inherit (feishu) pname;

  inherit (sources.${system} or (throw "Unsupported system: ${system}")) version src;

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r Lark.app $out/Applications

    runHook postInstall
  '';

  meta = feishu.meta // {
    maintainers = with lib.maintainers; [ prince213 ];
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  };
})
