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
    name = "libfole";

    src = fetchgit {
      url = "https://github.com/libyal/libfole.git";
      rev = "ea62ecf9e94e4607ffe458311485fe577a8bffc1";
      hash = "sha256-sfzJSjDsLpNOSSbsIKec1R3yRZkJGzPoZT5odxlU6AA=";
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
      for i in libcerror; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
