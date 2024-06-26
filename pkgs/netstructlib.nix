{ python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
  name = "netstruct";
  version = "0";
  
  src = fetchFromGitHub {
    owner = "stendec";
    repo = name;
    rev = "38c37dbc1cd42d45bdefe75bebb088054f6a3a5a";
    sha256 = "sha256-h+RvsPfL8tTdplehqQMS0AhybbqBgcI0o29/boRJZgQ=";
  };

  doCheck = false;
}
