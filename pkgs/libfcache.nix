{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata
, libcerror
, libcthreads
}:
stdenv.mkDerivation {
    name = "libfcache";

    src = fetchgit {
      url = "https://github.com/libyal/libfcache.git";
      rev = "4a4743abe3dd4b71ab1e456ee52e2c25a3320fe1";
      hash = "sha256-NVAiOshGyQ1xa3jJfnjwaqnyfyAYDTtCd8M3NyWoOn8=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcdata libcerror libcthreads
    ];

    preConfigure = ''
      for i in libcdata libcerror libcthreads; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
