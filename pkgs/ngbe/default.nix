{
  lib,
  fetchzip,
  kernel,
  libarchive,
  stdenv,
  unzip,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "ngbe";
  version = "1.2.6.5";

  src = fetchzip {
    name = "source";
    url = "https://www.net-swift.com/uploads/20250123/%E7%BD%91%E8%BF%85%E5%8D%83%E5%85%86%E7%BD%91%E5%8D%A1Linux%20PF%E9%A9%B1%E5%8A%A8%E6%BA%90%E7%A0%81.zip";
    hash = "sha256-ulC5AeH6RSjD/jI1kfgL/JgKcH6NNGmXUQYM3w3H1xg=";
    nativeBuildInputs = [ unzip ];
  };

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [ libarchive ];

  unpackPhase = ''
    runHook preUnpack
    bsdtar -x --strip-components 1 -f $src/ngbe-${finalAttrs.version}.zip
    runHook postUnpack
  '';

  sourceRoot = "src";

  patches = [
    # 6.10: https://github.com/torvalds/linux/commit/163943ac00cb31ac1a88ce5f78a7e2ead37329ec
    ./xsk_buff_dma_sync_for_cpu.patch
    # 6.11: https://github.com/torvalds/linux/commit/2111375b85ad173d58e7b8604246a3de60950ac8
    ./kernel_ethtool_ts_info.patch
    # 6.13: https://github.com/torvalds/linux/commit/4b42fbc6bd8f73d9ded535d8c61ccaa837ff3bd4
    ./ndo_fdb_add_notified.patch
  ];

  postPatch = ''
    substituteInPlace common.mk --replace-fail /sbin/depmod true
  '';

  makeFlags =
    let
      path = "${kernel.dev}/lib/modules/${kernel.modDirVersion}";
    in
    [
      "KSRC=${path}/source"
      "KOBJ=${path}/build"
      "INSTALL_MOD_PATH=$(out)"
      "MANDIR=/share/man"
    ];

  meta = {
    description = "WangXun Gigabit Ethernet Driver";
    homepage = "https://www.net-swift.com/";
    downloadPage = "https://www.net-swift.com/c/down.html?filter[type]=1";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ prince213 ];
    platforms = lib.platforms.linux;
    broken = kernel.kernelOlder "2.6";
  };
})
