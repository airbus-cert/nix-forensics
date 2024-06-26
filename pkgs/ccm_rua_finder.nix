{ stdenv
, fetchFromGitHub
, python
}:
stdenv.mkDerivation {
  pname = "ccm-rua-finder";
  version = "1.2";

  src = fetchFromGitHub {
    owner = "davidpany";
    repo = "WMI_Forensics";
    rev = "0ab08dca7938d26846497be9e450b7bb2ca7fff3";
    hash = "sha256-t9FZsSfxKVMwOFSYl3Ji7iZ6HWVgY+WLK7g4gz2+Yhs=";
  };

  buildPhase = ''
    substituteInPlace CCM_RUA_Finder.py \
      --replace '#!/usr/bin/env python' '#!${python}/bin/python2'
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp CCM_RUA_Finder.py $out/bin/
    chmod +x $out/bin/*
  '';

  dontFixup = true;  # fixup removes the shebang
}
