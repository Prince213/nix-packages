{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.12.0-beta.18";

  src = previousAttrs.src.override {
    hash = "sha256-R42+v/1TpnRJrGtftJjee4N+1W5BIK9JEC6UPZerXUw=";
  };

  vendorHash = "sha256-5AWJB5uckIKrYD+r9C7TfYQNBcz1gGkBNIOQelpahXQ=";

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
