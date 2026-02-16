{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.4";

  src = previousAttrs.src.override {
    hash = "sha256-dEjB8SvAIRvIbjQ0ToJypA2YxpFO5QYGhSK8ikmU8Ao=";
  };

  vendorHash = "sha256-zrrIS4v91qQPCpN4teE/qIQC1IDo0oEmB//q/+WfHg0=";
})
