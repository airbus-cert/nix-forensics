{ python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
    name = "regrippy";
    version = "0";
    
    src = fetchFromGitHub {
      inherit name;
      owner = "airbus-cert";
      repo = name;
      rev = "a7f11fb3d0d130559ad7d46200c73079c4ad2ecf";
      sha256 = "sha256-VlabTiJm70iPa9mrT2DHlHV3ld7nurKXthKDyqrY5so=";
    };

    patches = [
      ./patches/regrippy-change-argv0.patch
    ];

    propagatedBuildInputs = with python3Packages; [
      wheel
      setuptools
      python-registry
    ];

    postInstall = ''
      cp $out/bin/regrip.py $out/bin/regrippy

      # We need "regrip.py" to be available for "reg_*
      # scripts to import. However, we don't want users
      # being able to run it: they should go through "regrippy"
      chmod -x $out/bin/regrip.py
    '';

    doCheck = false;
  }
