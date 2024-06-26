{ python3Packages
, fetchFromGitHub
, netstructlib
}:
python3Packages.buildPythonPackage rec {
  name = "CobaltStrikeParser";
  version = "0";
  
  src = fetchFromGitHub {
    inherit name;
    owner = "nbareil";
    repo = name;
    rev = "fbd8c84de3c9ed1101ba698f397f310bf3bf8171";
    sha256 = "sha256-tlAyJofe6ATXHJTWFf8n1az9pZRDZ5PB83C6wYWgW38=";
  };
  
  propagatedBuildInputs = (with python3Packages; [
    urllib3
    requests
    pefile
  ]) ++ [ netstructlib ];
  
  doCheck = false;
}
