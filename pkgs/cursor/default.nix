{
  lib,
  appimageTools,
  fetchurl,
  installShellFiles,
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

appimageTools.wrapType2 rec {
  pname = "cursor";
  inherit version;

  src = sources.${system};

  nativeBuildInputs = [ installShellFiles ];

  extraInstallCommands =
    let
      appimageContents = appimageTools.extract {
        inherit pname version src;
      };
    in
    ''
      mkdir -p $out/share
      cp -r ${appimageContents}/usr/share/appdata $out/share/metainfo
      cp -r ${appimageContents}/usr/share/applications $out/share/
      cp -r ${appimageContents}/usr/share/mime $out/share/
      cp -r ${appimageContents}/usr/share/pixmaps $out/share/

      substituteInPlace $out/share/applications/* --replace-fail /usr/share/cursor/cursor cursor

      installShellCompletion --bash --cmd cursor \
        --bash ${appimageContents}/usr/share/bash-completion/completions/cursor \
        --zsh ${appimageContents}/usr/share/zsh/vendor-completions/_cursor
    '';

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
