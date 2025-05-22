{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: rec {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.16";

  src = previousAttrs.src.override {
    rev = "v${version}";
    hash = "sha256-mvJT3+l+bvYzx0yz6ll5luxFMRLLbOTWN+hAUbERqlg=";
  };

  vendorHash = "sha256-pDzaqRewJMBMaoUSGl789iWyBGICctjJ97cW0UfHASY=";

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

  postInstall =
    previousAttrs.postInstall
    + ''
      install -Dm444 release/config/sing-box.sysusers $out/lib/sysusers.d/sing-box.conf
      install -Dm444 release/config/sing-box.rules $out/share/polkit-1/rules.d/sing-box.rules
      install -Dm444 release/config/sing-box-split-dns.xml $out/share/dbus-1/system.d/sing-box-split-dns.conf
    '';
})
