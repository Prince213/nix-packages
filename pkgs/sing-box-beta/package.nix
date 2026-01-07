{
  sing-box,
}:

sing-box.overrideAttrs (previousAttrs: {
  pname = previousAttrs.pname + "-beta";
  version = "1.13.0-beta.1";

  src = previousAttrs.src.override {
    hash = "sha256-6MdJPZylchHaXRIvgki31+XZeBl4xjswu/vWwGyyqAY=";
  };

  vendorHash = "sha256-0VwyZxGs6i+HWvAWowpidkRs4vTvpjcP0QpO+fUrZF8=";
})
