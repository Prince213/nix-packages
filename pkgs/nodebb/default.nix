{
  buildNpmPackage,
  fetchFromGitHub,
  lib,
  pkg-config,
  vips_8_14_5,
}:

buildNpmPackage (finalAttrs: {
  pname = "nodebb";
  version = "4.4.2";

  src = fetchFromGitHub {
    owner = "NodeBB";
    repo = "NodeBB";
    tag = "v${finalAttrs.version}";
    hash = "sha256-0H+Ruz/KAH8lZPxp1An4z8syg8URPRqsFAnvQsAVqOo=";
  };

  postPatch = ''
    cp ./install/package.json .
    cp ${./package-lock.json} ./package-lock.json
  '';

  npmDepsHash = "sha256-tZ4J0a/0tVbN/HdcIgng3hvRg47vo/CDd/K3YcrDRCE=";
  makeCacheWritable = true;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    vips_8_14_5
  ];

  dontNpmBuild = true;

  meta = {
    description = "Forum software";
    homepage = "https://nodebb.org/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ prince213 ];
    platforms = lib.platforms.all;
  };
})
