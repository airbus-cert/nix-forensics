{ python3Packages
, splunklib
, domaintoolslib
, pymisplib
}:
python3Packages.buildPythonPackage rec {
    pname = "huntlib";
    version = "0.5.3";

    src = python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "1z361fm23dnn7xxfjcbll8xx0g3hqn2p1y1fp9zisq4my37wiram";
    };

    propagatedBuildInputs = (with python3Packages; [
      pytest-runner
      numpy
      pandas
      tqdm
      elasticsearch-dsl
      future
      jellyfish
      scipy
    ]) ++ [ splunklib domaintoolslib pymisplib ];

    doCheck = false;
  }
