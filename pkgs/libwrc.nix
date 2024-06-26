{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libexe, libfcache, libfdata, libfdatetime, libfguid, libfvalue, libfwnt, libuna
}:
stdenv.mkDerivation {
    name = "libwrc";

    src = fetchgit {
      url = "https://github.com/libyal/libwrc.git";
      rev = "2fe9efd54fe9c1749b3f1051a8c764fb946dab2d";
      hash = "sha256-eO9ootimmidChhVzdKuUP/efsctWhRUMleYdtmV5IB8=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwnt libuna
    ];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwnt libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
