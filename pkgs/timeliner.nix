{ buildGoModule
, fetchFromGitHub
}:
buildGoModule rec {
    name = "timeliner";

    src = fetchFromGitHub {
      owner = "airbus-cert";
      repo = name;
      rev = "b068f5f164eae9a729989697ff25656f86a67287";
      hash = "sha256-qWqwM/AIFMZ6giAEqEa9GhJFbUzARiudWVaN2fGrlJA=";
    };

    vendorHash = "sha256-L0EQy6AoaoJrcSDSTx4owhGmUtlMH60Okr5fL7rDhzQ=";

    postInstall = ''
      mv $out/bin/main $out/bin/timeliner
    '';

    meta = {
      description = "user-friendly browser of bodyfile";
      homepage = "https://github.com/airbus-cert/timeliner";
    };
  }
