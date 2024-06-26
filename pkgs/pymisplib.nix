{ python3Packages
}:
python3Packages.buildPythonPackage rec {
    pname = "pymisp";
    version = "2.4.165.1";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-ddwm8hIikpNZASTCCPw+HzGMvYn6WJC9cRjcmxXz6S0=";
    };

    propagatedBuildInputs = with python3Packages; [
      requests
      deprecated
      dateutil
      jsonschema
    ];
    doCheck = false;
  }
