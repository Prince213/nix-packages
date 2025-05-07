{
  lib,
  appimageTools,
  fetchurl,
  stdenvNoCC,
}:

let
  inherit (stdenvNoCC.hostPlatform) system;
  version = "0.49.6";
  path = "https://downloads.cursor.com/production/0781e811de386a0c5bcb07ceb259df8ff8246a52";
  sources = {
    aarch64-linux = fetchurl {
      url = "${path}/linux/arm64/Cursor-${version}-aarch64.AppImage";
      hash = "sha256-cpNoff6mDRkT2RicaDlxzqVP9BNe6UEGgJVHr1xMiv0=";
    };
    x86_64-linux = fetchurl {
      url = "${path}/linux/x64/Cursor-${version}-x86_64.AppImage";
      hash = "sha256-WH4/Zw0VJmRGyRzMlkThkhZ4fGysMKBUSIPCTsyGS4w=";
    };
  };
in

appimageTools.wrapType2 {
  pname = "cursor";
  inherit version;

  src = sources.${system};

  meta = {
    description = "AI-first code editor";
    homepage = "https://www.cursor.com/";
    downloadPage = "https://www.cursor.com/downloads";
    changelog = "https://www.cursor.com/changelog";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    maintainers = with lib.maintainers; [ prince213 ];
    mainProgram = "cursor";
    platforms = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
