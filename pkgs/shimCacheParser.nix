{ stdenv
, fetchFromGitHub
, python3Packages
, dos2unix
}:
stdenv.mkDerivation rec {
  name = "ShimCacheParser";
  version = "fd8946b898926637179e6f15a2d099f71351c433";
  
  src = fetchFromGitHub {
    owner = "comawill";
    repo = name;
    rev = version;
    sha256 = "sha256-2dX/BynAZmHMA411Q4Plby/rDN6KF2Ia9V/M4elEiB4=";
  };
  
  propagatedBuildInputs = with python3Packages; [
    wheel
    python-registry
  ];

  nativeBuildInputs = [
    dos2unix
  ];

  buildPhase = ''
    runHook preBuild

    dos2unix ShimCacheParser.py
    patchShebangs ShimCacheParser.py
  
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    
    mkdir -p $out/bin/
    cp ShimCacheParser.py $out/bin/

    runHook postInstall
  '';
  
  doCheck = false;
}
