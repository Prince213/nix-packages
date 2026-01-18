{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "dn42_registry_wizard";
  version = "0.4.17";

  src = fetchFromGitHub {
    owner = "Kioubit";
    repo = "dn42_registry_wizard";
    tag = "v${finalAttrs.version}";
    hash = "sha256-wczsDKHcf/izEhJp9THL9yoEfZHTZ0FoVU4CTxmNuAY=";
  };

  cargoHash = "sha256-Op0xjblw3fB1boRaYoVH9O+c2Zodi/TtJ6sQSiz/rLo=";

  meta = {
    description = "Collection of tools to interact with DN42 registry data";
    homepage = "https://github.com/Kioubit/dn42_registry_wizard";
    downloadPage = "https://github.com/Kioubit/dn42_registry_wizard/releases";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ prince213 ];
  };
})
