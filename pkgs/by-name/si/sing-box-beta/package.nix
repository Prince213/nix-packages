{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.14.0-beta.7";
  __structuredAttrs = true;

  src = previousAttrs.src.override {
    hash = "sha256-wLjezKTIVLbXsTgHQyaPyrOmoG8iPTKpapjHT7W1z+I=";
  };

  vendorHash = "sha256-QDRLNatY0PHhM1GGusK/SOlCAK1le9Bf3t3Ns8rPG0Q=";

  tags = previousAttrs.tags ++ [
    "with_cloudflared"
    "with_usbip"
    "with_openvpn"
    "with_openconnect"
  ];
})
