{ python3
, writeScriptBin
}:
let
  py = python3.override {
    packageOverrides = self: super: rec {
      construct =  self.buildPythonPackage rec {
        pname = "construct";
        version = "2.8.12";

        src = self.pkgs.python3Packages.fetchPypi {
          inherit pname version;
          hash = "sha256-Z+4saaEb2twHBcfg3g/xbvdLcwkyU34irB9k9HkkD/o=";
        };
    
        doCheck = false;
      };

      bits_parser = self.buildPythonPackage rec {
        pname = "bits_parser";
        version = "1.0.1";

        src = self.pkgs.fetchPypi {
          inherit pname version;
          hash = "sha256-2PsfNBdKtxjzmGvLaUQyVobR0Dn6CZ/9t/sVm/sH9gg=";
        };

        propagatedBuildInputs = [ 
          self.pkgs.python3Packages.docopt
          construct
        ];

        doCheck = false;
      };
    };
  };

  python-env = py.withPackages (ps: [ ps.construct ps.bits_parser ]);
in
writeScriptBin "bits_parser" ''
  export PYTHONPATH=""
  ${python-env}/bin/bits_parser $@
''
