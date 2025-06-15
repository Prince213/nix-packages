{
  cmake,
  curl,
  fetchFromGitHub,
  fetchpatch2,
  gtest,
  kdePackages,
  lib,
  libcap,
  libelf,
  libseccomp,
  nlohmann_json,
  ostree,
  pkg-config,
  stdenv,
  yaml-cpp,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "linglong";
  version = "1.8.0";

  src = fetchFromGitHub {
    owner = "OpenAtom-Linyaps";
    repo = "linyaps";
    tag = "${finalAttrs.version}";
    hash = "sha256-grQ+iJBLEtwvfSFipZlbWl4ZhIrPXzDZjOSaqKfAzqI=";
  };

  patches = [
    ./sysconfdir.patch
    (fetchpatch2 {
      url = "https://github.com/OpenAtom-Linyaps/linyaps/commit/6cdc6ca73dee224348a1df14e32152a1b0ba943f.patch?full_index=1";
      hash = "sha256-BREA0o5nOD7UKjcScqzBf2I/QBwA5ZlwDOXs0IAp6UE=";
    })
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    kdePackages.wrapQtAppsNoGuiHook
  ];

  buildInputs = [
    curl
    gtest
    kdePackages.qtbase
    libcap
    libelf
    libseccomp
    nlohmann_json
    ostree
    yaml-cpp
  ];

  cmakeFlags = [
    (lib.cmakeBool "CPM_LOCAL_PACKAGES_ONLY" true)
  ];

  postInstall = ''
    substituteInPlace $out/bin/llpkg \
      --replace-fail "exec ll-cli" "exec $out/bin/ll-cli"
  '';

  meta = {
    description = "Package manager";
    homepage = "https://linyaps.org.cn/en";
    downloadPage = "https://github.com/OpenAtom-Linyaps/linyaps/releases";
    changelog = "https://github.com/OpenAtom-Linyaps/linyaps/releases/tag/${finalAttrs.src.tag}";
    license = lib.licenses.lgpl3Plus;
    maintainers = with lib.maintainers; [ prince213 ];
    platforms = lib.platforms.linux;
  };
})
