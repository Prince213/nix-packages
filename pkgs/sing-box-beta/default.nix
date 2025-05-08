{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.11";

  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-vpRy/uQZ0RwBIoMQ7u8tuaB7TI4ca6R8ZwSp7918wuw=";
  };

  vendorHash = "sha256-BMyOEMIWtnDOe46mcR5tujYW0TFsawqLzMqGNRCYLXQ=";

  tags = [
    "with_quic"
    "with_dhcp"
    "with_wireguard"
    "with_utls"
    "with_acme"
    "with_clash_api"
    "with_gvisor"
    "with_tailscale"
  ];

  ldflags = [
    "-X=github.com/sagernet/sing-box/constant.Version=${version}"
  ];
})
