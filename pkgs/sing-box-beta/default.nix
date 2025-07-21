{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.35";

  src = previousAttrs.src.override {
    hash = "sha256-cIkanMoGVHQPk9unPFFioKRT7dbWDbGw6Qn1OxcKC/Q=";
  };

  vendorHash = "sha256-0lBe2kCnr+A6z5sInfMUurqXyKRMEJTSFPTi0Z7P498=";

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

  postInstall =
    previousAttrs.postInstall
    + ''
      install -Dm444 release/config/sing-box.sysusers $out/lib/sysusers.d/sing-box.conf
      install -Dm444 release/config/sing-box.rules $out/share/polkit-1/rules.d/sing-box.rules
      install -Dm444 release/config/sing-box-split-dns.xml $out/share/dbus-1/system.d/sing-box-split-dns.conf
    '';
})
