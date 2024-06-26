{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
}:
stdenv.mkDerivation {
    name = "libcdatetime";

    src = fetchgit {
      url = "https://github.com/libyal/libcdatetime.git";
      rev = "fba481205729a88982764c16f46d9d66cf1fd8c4";
      hash = "sha256-+1X2ePVzDLqv/nsXsEKeliJ4XjNXC1N7ntdA5Dc41s0";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
    ];

    preConfigure = ''
      sed -i 's!AC_CONFIG_FILES..libcerror/Makefile..!!g' configure.ac;
      sed -i '/libcerror /d' Makefile.am
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
