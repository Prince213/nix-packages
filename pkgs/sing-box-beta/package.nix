{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-rc.3";

  src = previousAttrs.src.override {
    hash = "sha256-5b2uedwWG8RR+WpGjHqUNrW1+O3O8JmMCGXR4BQstn8=";
  };

  vendorHash = "sha256-zrrIS4v91qQPCpN4teE/qIQC1IDo0oEmB//q/+WfHg0=";
})
