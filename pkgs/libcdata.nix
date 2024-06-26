{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
, libcthreads
}:
stdenv.mkDerivation {
    name = "libcdata";

    src = fetchgit {
      url = "https://github.com/libyal/libcdata.git";
      rev = "ed66801e97c516c405486508d280fda3e8114e9d";
      hash = "sha256-hFgb7mb02KjJb1aFuAlYPUbux7zMvd8pnNAnYxbINzk=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
      libcthreads
    ];

    preConfigure = ''
      sed -i -e '/AC_CONFIG_FILES..libcerror.Makefile/d' -e '/AC_CONFIG_FILES..libcthreads.Makefile/d' configure.ac;
      sed -i -e '/libcerror /d' -e '/libcthreads /d' Makefile.am
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
