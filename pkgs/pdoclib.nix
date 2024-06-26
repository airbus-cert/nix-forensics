{ python3Packages
, fetchFromGitHub
}:
python3Packages.buildPythonPackage rec {
    name = "pdoc";

    src = fetchFromGitHub {
      inherit name;
      owner = "mitmproxy";
	    repo = "pdoc";
      rev = "v9.0.0";
      sha256 = "0xrv6iqf1h3pd0v0k8ww2z2zy071xj5m7kvwx0kk6z7rah5arng9";
    };

    propagatedBuildInputs = with python3Packages; [
      jinja2
      pygments
      markupsafe
      astunparse
    ];
    doCheck = false;
  }
