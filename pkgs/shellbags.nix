{ python2Packages
, fetchFromGitHub
}:
python2Packages.buildPythonPackage rec {
    name = "shellbags";
    version = "0";
    
    src = fetchFromGitHub {
      inherit name;
      owner = "williballenthin";
      repo = name;
      rev = "fee76eb25c2b80c33caf8ab9013de5cba113dcd2";
      sha256 = "sha256-nygK8J7Te9cUcvaZTgpmn3qQDr6zzvzfIK28a46B5qM=";
    };
    
    propagatedBuildInputs = with python2Packages; [
      wheel
      python-registry
      six
    ];
    doCheck = false;
  }
