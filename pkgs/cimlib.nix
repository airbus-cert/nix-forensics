{ fetchzip
, fetchPypi
, fetchFromGitHub
, stdenv
, python3Packages
}:
let
  vivisect-vstruct-wb = python3Packages.buildPythonPackage rec {
    name = "vivisect-vstruct-wb";
    version = "1.0.3";

    src = fetchPypi {
      pname = name;
      inherit version;

      hash = "sha256-ARmysahiYHLfxixviuISC/19WS8lgfGN+g1/CvtBMU8=";
    }; 

    doCheck = false;
  };

  python-cim = python3Packages.buildPythonPackage {
    name = "python-cim";
    version = "0";

    src = fetchzip {
      url = "https://files.pythonhosted.org/packages/99/bc/7b42191a29bdffa4d1b36cafcae0d6434ec18babc804b644f698ab2c1399/python-cim-1.1.zip";
      hash = "sha256-u+ibNpNo5ZhQVrexqSyJmlfPBO7xH/lz37Of2CsNbuA=";
    };

    propagatedBuildInputs = with python3Packages; [
      hexdump
      funcy
      intervaltree
    ] ++ [ vivisect-vstruct-wb ];
    
    doCheck = false;
  };
in
python3Packages.buildPythonPackage rec {
  name = "python-cim-samples";
  version = "b0a5a094ff9ca7d7a1c4fc711dc00c74dec4b6b1";

  src = fetchFromGitHub {
    owner = "mandiant";
    repo = "flare-wmi";

    rev = version;
    hash = "sha256-N1DkQHGw+lcLo1jyFmQcw/jtcC+UbDwxQK7LhzLj1rE=";
  };

  propagatedBuildInputs = [
    python-cim
  ];

  prePatch = ''
    cd python-cim
  '';

  patchPhase = ''
    runHook prePatch

    sed -i '1 i\#!/usr/bin/env python3' samples/*.py

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp samples/show_*.py $out/bin/
    chmod +x $out/bin/*
    
    runHook postInstall
  '';

  doCheck = false;
}
