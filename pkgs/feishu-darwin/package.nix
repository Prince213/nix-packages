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
        version = "7.58.8";
        src = fetchurl {
          url = "${base}/ee-appcenter/2b81c033/Feishu-darwin_arm64-7.58.8-signed.dmg";
          hash = "sha256-bP0rxcX4PmBz6yGARFj9KXbEUn8Nu4R54KfaKZOYLRM=";
        };
      };
      # curl 'https://www.feishu.cn/api/package_info?platform=6'
      x86_64-darwin = {
        version = "7.58.8";
        src = fetchurl {
          url = "${base}/ee-appcenter/f4b3710d/Feishu-darwin_x64-7.58.8-signed.dmg";
          hash = "sha256-YW8pWH8fPGrYaGYf8Aebgpa5lmxAwfmNhf5QCdQnAq4=";
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
