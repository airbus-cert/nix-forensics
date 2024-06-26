{ python3Packages
, fetchFromGitHub
, libfwsi
}:
python3Packages.buildPythonPackage rec {
    name = "regipy";
    version = "3.1.6";
    
    src = fetchFromGitHub {
      owner = "mkorman90";
      repo = name;
      rev = version;
      sha256 = "sha256-I5B6c3ARjrBrMF/1Y6i+BUsNykamHiuz0X7gkuwbwtA=";
    };
    propagatedBuildInputs = (with python3Packages; [
      attrs
      construct
      inflection
      pytz
      click
      tabulate
    ]) ++ [ libfwsi ];
    doCheck = false;
}
