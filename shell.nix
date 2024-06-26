let
  pkgs = import (fetchTarball "https://github.com/nixos/nixpkgs/archive/56b667b4a7bc98bf219f6410bdffd1e60dab4bbf.tar.gz") {};
  my = import ./default.nix { inherit pkgs; };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    my.customPython
    my.evtxTools
    my.usnrs
    my.INDXRipper
    my.INDXParse
    my.CobaltStrikeParser
    my.libvmdk
    my.libmsiecf
    my.libvhdi
    my.libvshadow
    my.liblnk
    my.libesedb
    my.timeliner
    my.cimlib
    my.bits_parser
    my.at_jobs_carver
    my.ccm_rua_finder
    my.forensicslab

    (python2.withPackages (ps: [
      (my.shellbags ps)
    ]))

    #my.srum-dump
    my.shimCacheParser
    #my.mftspy
    my.dfir_ntfs
    my.yarp
    my.regrippy
    my.regipy
    my.amcacheparser
    my.registryFlush

    my.my-python-registry

    lief
    python3Packages.lief
    flare-floss
    nasm
    libbde
    libewf
    ssdeep
    ntfs3g
    yara
    yarGen
    sleuthkit
    multipath-tools
    parted
    parallel
    moreutils
    fuse
    fd
    ripgrep
    sigma-cli
    squashfs-tools-ng
    squashfsTools
    squashfuse
    tmux
    volatility3
    regripper
  ];

  shellHook = ''
    source forensicslab
  '';
}
