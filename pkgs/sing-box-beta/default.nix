{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.13";

  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-NJFN68C6YKK6QdSuJNeCoYjYVJ66WBNS6cnR+on1WDg=";
  };

  vendorHash = "sha256-/O+CqbkgBBNlkF50smcxRPDMc4DREnGL60BUSTvDO7Y=";

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
