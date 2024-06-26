{ fetchFromGitHub
, python3Packages
}:
python3Packages.buildPythonPackage rec {
  name = "yarp";
  version = "1.0.33";
  
  src = fetchFromGitHub {
    owner = "msuhanov";
    repo = name;
    rev = version;
    sha256 = "sha256-obPculLv8rGAit94CjlyzBDeo6CAO2Ayr1LCixcAtkA=";
  };
  
  doCheck = false;
}
