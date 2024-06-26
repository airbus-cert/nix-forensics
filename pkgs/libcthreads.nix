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
    name = "libcthreads";

    src = fetchgit {
      url = "https://github.com/libyal/libcthreads.git";
      rev = "b80e4921334bfe06eb3ac3a9ea0912e06c6ad31e";
      hash = "sha256-FS71tEJXjACrLbt+BdlFOux+sHBdiQfNqUGrxJ8qcms=";
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
