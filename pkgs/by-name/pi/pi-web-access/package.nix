{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage (finalAttrs: {
  pname = "pi-web-access";
  version = "0.36.0";

  __structuredAttrs = true;

  src = fetchFromGitHub {
    owner = "nicobailon";
    repo = "pi-web-access";
    tag = "v${finalAttrs.version}";
    hash = "sha256-vXdaYGy7GLs1Yg5TXRoO4QFtkN2LR02nDqSnRyqftnM=";
  };

  patches = [ ./no-pi-deps.patch ];

  npmDepsFetcherVersion = 2;
  npmDepsHash = "sha256-kELQfl9By29yM581To47KnJrPhQFXq/lernNXfihRqc=";

  npmPruneFlags = [ "--omit=peer" ];

  postBuild = ''
    node scripts/pi-extensions-dist.js dist
  '';

  meta = {
    description = "Web search and content extraction extension for Pi coding agent";
    homepage = "https://github.com/nicobailon/pi-web-access";
    downloadPage = "https://github.com/nicobailon/pi-web-access/releases";
    changelog = "https://github.com/nicobailon/pi-web-access/blob/v${finalAttrs.version}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ prince213 ];
  };
})
