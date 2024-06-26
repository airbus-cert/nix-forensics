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
    name = "libclocale";

    src = fetchgit {
      url = "https://github.com/libyal/libclocale.git";
      rev = "45b989bec6c5578b762f5b13dbce03aa2e999426";
      hash = "sha256-tLEcKlLs7KqVfXZkYs+rxS7lwrY2r4SY1Mdqwgu8O34=";
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
