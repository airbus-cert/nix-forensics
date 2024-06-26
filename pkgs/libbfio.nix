{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata
, libcfile
, libcpath
, libcsplit
, libuna
, libcerror
, libcthreads
, libcnotify
, libclocale
}:
stdenv.mkDerivation {
    name = "libbfio";

    src = fetchgit {
      url = "https://github.com/libyal/libbfio.git";
      rev = "2bde498a8fbe0155fc7fbcd9c56de7cadc2dcb8d";
      hash = "sha256-Vx8IXIgCgC9xJfUEpyAT89rxBG0KsT5ajh7ZIQp5V/4=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna
    ];

    preConfigure = ''
      for i in libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
