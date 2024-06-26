{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
}:
stdenv.mkDerivation {
    name = "libcerror";

    src = fetchgit {
      url = "https://github.com/libyal/libcerror.git";
      rev = "9b13d0ca59dcc83f94eef7c6c4e99c46b84550c8";
      hash = "sha256-QdjpYOtK9vofRqEywZ4qFrnM9guUNy8medPMTsmol5E=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    preConfigure = "autoreconf --install";

    buildInputs = [
    ];
}
