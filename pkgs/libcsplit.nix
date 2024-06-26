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
    name = "libcsplit";

    src = fetchgit {
      url = "https://github.com/libyal/libcsplit.git";
      rev = "b4baf41a06421aaf725b11ebed8c040ad34e8761";
      hash = "sha256-xxt79HEr6mhQtb/BBco8e35wYEtdqwT8q+V5oJRIzzU=";
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
