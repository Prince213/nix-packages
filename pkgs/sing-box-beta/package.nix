{
  fetchurl,
  go,
  lib,
  sing-box,

  withNaiveOutbound ? false,
}:

sing-box.overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = previousAttrs.pname + "-beta";
    version = "1.13.0-rc.6";

    src = previousAttrs.src.override {
      hash = "sha256-yNZGUiNZh7fyW/BFgXcZg4ttnldRIDkB2KJ/MK5NH5E=";
    };

    modPostBuild = (previousAttrs.modPostBuild or "") + ''
      cd vendor/github.com/sagernet/cronet-go
      patch -p1 < ${./cronet-go.patch}
      cd ../../../..
    '';

    vendorHash = "sha256-cxsUOMBuRFViUSQiDd2gQ7nzk+g4B908NTsAr4x7jtk=";

    tags =
      previousAttrs.tags
      ++ lib.optionals withNaiveOutbound [
        "with_purego"
        "with_naive_outbound"
      ];

    postInstall = previousAttrs.postInstall + ''
      ln -s "${finalAttrs.passthru.libcronet}" "$out/lib/libcronet.so"
    '';

    passthru = previousAttrs.passthru // {
      libcronet =
        let
          system = "${go.GOOS}-${go.GOARCH}";
        in
        fetchurl {
          url = "https://github.com/SagerNet/cronet-go/releases/download/v0.0.1-143.0.7499.109-1/libcronet-${system}.so";
          hash =
            {
              linux-386 = "sha256-iSvzlXZq1sYikgRYz/30YtW9WqORy8C1yH7wCSORh18=";
              linux-amd64 = "sha256-ofBH9DDdkQUvSXfEljbcRNMvLk2d/o5UHbS86MPqa2Y=";
              linux-arm = "sha256-vRxPt98MnnlI8KuAcJYStm83p5mPJ+KmpJ0azu+i0PY=";
              linux-arm64 = "sha256-4bUjDXQbHS3KktvI9AGRlWDQYtXUHooj8Tko52EzW0Y=";
            }
            .${system} or (throw "Unsupported system: ${system}");
        };
    };
  }
)
