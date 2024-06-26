{ rustPlatform
, fetchFromGitHub
}:
rustPlatform.buildRustPackage rec {
    pname = "usnrs";
    version = "v0.1.0";

    buildFeatures = [ "usnrs-cli" ];

    src = fetchFromGitHub {
      inherit pname version;
      owner = "airbus-cert";
      repo = pname;
      rev = version;
      sha256 = "sha256-zBSMIXRjAGuerkaTIGgn7TCrVnxprrXCIjV5OFIvMuU=";
    };

    cargoSha256 = "sha256-Ogp5e4Ai4xzEUPT/tGEN+zG2GMTcDkvCftG5NJLliZ8=";

    meta = {
      description = "A cross-platform parser for the Windows USN Journal format";
      homepage = "https://github.com/airbus-cert/usnrs";
    };
  }
