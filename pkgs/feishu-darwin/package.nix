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
        version = "7.54.8";
        src = fetchurl {
          url = "${base}/ee-appcenter/e9f61856/Feishu-darwin_arm64-7.54.8-signed.dmg";
          hash = "sha256-rvsbrS2W25+yh40QweK8ZrONS+qzH6SnJ7aXCx+NW/s=";
        };
      };
      # curl 'https://www.feishu.cn/api/package_info?platform=6'
      x86_64-darwin = {
        version = "7.54.8";
        src = fetchurl {
          url = "${base}/ee-appcenter/0ed88891/Feishu-darwin_x64-7.54.8-signed.dmg";
          hash = "sha256-pC6bgKiVAF+6na/RqL22CMBX+62MgPvfsFpoW2MCJb4=";
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
