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
        version = "7.56.5";
        src = fetchurl {
          url = "${base}/ee-appcenter/97fd5e6f/Feishu-darwin_arm64-7.56.5-signed.dmg";
          hash = "sha256-QKa6dDixyV17qFROCRkFRPOo+Opegxl6xBpFnBGsKlo=";
        };
      };
      # curl 'https://www.feishu.cn/api/package_info?platform=6'
      x86_64-darwin = {
        version = "7.56.5";
        src = fetchurl {
          url = "${base}/ee-appcenter/d2383315/Feishu-darwin_x64-7.56.5-signed.dmg";
          hash = "sha256-HtO5pQiqrqLLfCHvYPjdT7yjTqvBsmXowR1h6r7zPZE=";
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
