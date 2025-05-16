{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.14";

  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-WSCm8vVXGj0UeOCqtWzqe+/ohetQ4noIR7scajW2T9k=";
  };

  vendorHash = "sha256-l3a4oYx4dZD1vyPhKEf9/JL1WzMyp36t7pcDIgLXcqc=";

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
