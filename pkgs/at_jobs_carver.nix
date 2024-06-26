{ python3
, stdenv
, fetchFromGitHub
}:
stdenv.mkDerivation {
  pname = "at_jobs_carver";
  version = "20160120";

  src = fetchFromGitHub {
    owner = "binglot";
    repo = "misc";
    rev = "45803e9a4f905a160635dc13c99a5ddc3b5d741b";
    hash = "sha256-dMiJ1P+8H3w7TLky7mMqJTPakfHB12W7Q2t8TDgqJSE=";
  };

  buildPhase = ''
    echo "#!${python3}/bin/python" | cat - $src/at_jobs_carver.py | tee at_jobs_carver.py
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp at_jobs_carver.py $out/bin/at_jobs_carver.py

    chmod +x $out/bin/at_jobs_carver.py
  '';  
}
