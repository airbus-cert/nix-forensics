{ buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
    name = "timeliner";

    src = fetchFromGitHub {
      owner = "airbus-cert";
      repo = name;
      rev = "a41292eec4bb99e5c253343b4e426dee1858906c";
      hash = "sha256-KwYguwCNSE1elKbyiWFf6nuRs67GVAxEMAPsQJSU1PE=";
    };

    vendorHash = "sha256-m/VyKp0mTLAhjLJIhKBYGauavzk09SYlO94SwuQ2icw=";

    postInstall = ''
      mv $out/bin/main $out/bin/timeliner
    '';

    meta = {
      description = "user-friendly browser of bodyfile";
      homepage = "https://github.com/airbus-cert/timeliner";
    };
  }
