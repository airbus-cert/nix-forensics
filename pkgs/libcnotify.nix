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
    name = "libcnotify";

    src = fetchgit {
      url = "https://github.com/libyal/libcnotify.git";
      rev = "d1bd4e920356ecd29c66f4d21bb36fa2834dbf31";
      hash = "sha256-+5ZqteKC+VcGXTbql47ufPkGFSp5j9cxdhajWu2d3OQ=";
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
