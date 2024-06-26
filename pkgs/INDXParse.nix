{ python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
  name = "INDXParse";
  version = "038e8ec836cf23600124db74b40757b7184c08c5";
  
  src = fetchFromGitHub {
    owner = "williballenthin";
    repo = name;
    rev = version;
    sha256 = "sha256-2nf9zeH+TArtP1XpXsv8P9K8NO6fXLasI4QYkJvCeI8=";
  };

  postPatch = ''
    # Fix list_mft sometimes choking on bad UTF-16 strings
    sed -i 's/decode("utf-16le")/decode("utf-16le", "backslashreplace")/' indxparse/BinaryParser.py
  '';
  
  propagatedBuildInputs = with python3Packages; [
    jinja2
    fuse
    enum-compat
  ];
  
  doCheck = false;
}
