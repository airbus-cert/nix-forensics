{ python3Packages}:
python3Packages.buildPythonPackage rec {
    pname = "splunk-sdk";
    version = "1.6.18";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "0q95bq5hkrd0a8hnr7w4fx4mixyv231k71m9bciapp7mhsbrbh7d";
    };

    doCheck = false;
  }
