{ python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
  name = "domaintools-api";
  version = "0.6.1";
  
  src = fetchFromGitHub {
    inherit name;
    owner = "domaintools";
    repo = "python_api";
    rev = "2b17d105e9fe1d51365a7abc59a904c2f2702169";
    sha256 = "sha256-qpIVw1bdef5rE5RjCsTchOd1DELP2yjRaz9t/2BRN50=";
  };
  propagatedBuildInputs = with python3Packages; [
    aiohttp
    requests
  ];
  doCheck = false;
}
