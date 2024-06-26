{ rustPlatform
, fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
    pname = "evtx";
    version = "v0.8.1";

    src = fetchFromGitHub {
      inherit pname version;
      owner = "omerbenamram";
      repo = pname;
      rev = version;
      sha256 = "sha256-aa04Ia11+Ae1amc3JAtYdSWf+f/fenTt0Bny/AauaHo=";
    };

    cargoSha256 = "sha256-pfTWbMWLdzA+AIZRmQebNh1vroVDxjaJjxxlm1fPdPY=";

    meta = {
      description = "A cross-platform parser for the Windows XML EventLog format";
      homepage = "https://github.com/omerbenamram/evtx";
    };
  }
