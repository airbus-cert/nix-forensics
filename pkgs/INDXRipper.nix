{ python3Packages
, fetchFromGitHub
, stdenv
, python3
}:
stdenv.mkDerivation rec {
  name = "INDXRipper";
  version = "1f5bfcb6b6d978dc64c4bfd3605286ea37cc19a2";
  
  src = fetchFromGitHub {
    owner = "harelsegev";
    repo = name;
    rev = version;
    hash = "sha256-ZOytGXvuYDC2A+eDLMbTfNrIjfdOvs3wojWSG1UQvig=";
  };
  
  propagatedBuildInputs = with python3Packages; [
    construct
  ];

  patchPhase = ''
    runHook prePatch

    sed -i '1 i\#!/usr/bin/env python3' INDXRipper.py
    patchShebangs INDXRipper.py

    runHook postPatch
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp *.py $out/bin/
    chmod +x $out/bin/INDXRipper.py
    
    runHook postInstall
  '';
  
  doCheck = false;
}