{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
, libclocale
, libuna
}:
stdenv.mkDerivation {
    name = "libcdirectory";

    src = fetchgit {
      url = "https://github.com/libyal/libcdirectory.git";
      rev = "43ebd87c486aedd8a7219554e6ceea47f970af5f";
      hash = "sha256-MVdNm/no35xSjj7qp0DJDBEEMzGNJ62/RUW4+0Hu4eo=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror libclocale libuna
    ];

    preConfigure = ''
      for i in libcerror libclocale libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
