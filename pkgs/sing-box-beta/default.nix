{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-rc.2";

  src = previousAttrs.src.override {
    hash = "sha256-VftcUOXQRkeaMJ3Bz4xO+aSzSoXb2Rh9dVNfrqAr8JQ=";
  };

  vendorHash = "sha256-tyGCkVWfCp7F6NDw/AlJTglzNC/jTMgrL8q9Au6Jqec=";

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
