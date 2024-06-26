{ python3
, stdenv
, yarp
, fetchurl
, wrapPython
}:
stdenv.mkDerivation rec {
  pname = "registryFlush";
  version = "7ed874033c5db290bbeebb07f6b6541761e64e14";

  src = fetchurl {
    url = "https://github.com/Silv3rHorn/4n6_misc/raw/${version}/registryFlush.py";
    hash = "sha256-qeQsHBzXHSmNrccfKAoubxtZWei4+Sv7TvVE9DSQXCc=";
  };

  patches = [
    ./patches/registryFlush-correct-exit-code.patch
  ];

  dontUnpack = true;
  dontBuild = true;

  buildInputs = [ python3 ];
  propagatedBuildInputs = [ yarp ];
  nativeBuildInputs = [ wrapPython ];

  # This makes sure "patch" finds the file it's looking for
  prePatch = ''
    mkdir workdir
    cp $src workdir/registryFlush.py
    cd workdir
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin/
    cp registryFlush.py $out/bin/registryFlush.py
    chmod +x $out/bin/registryFlush.py
    
    runHook postInstall
  '';

  postFixup = ''
    wrapPythonPrograms
  '';
}
