{ python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
  name = "dfir_ntfs";
  version = "1.1.18";
  
  src = fetchFromGitHub {
    owner = "msuhanov";
    repo = name;
    rev = version;
    sha256 = "sha256-qFNIyfJIERn77yCTlqxCuw2mlDWjHxS8Ps9C8WQeld8=";
  };

  propagatedBuildInputs = with python3Packages; [
    fuse
  ];
  
  doCheck = false;
}
