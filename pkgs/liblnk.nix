{ stdenv
, fetchurl
, fuse
, python3
, lib
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfdatetime, libfguid, libfole, libfwps, libfwsi, libuna
}:
stdenv.mkDerivation rec {
    name = "liblnk";

    src = fetchgit {
      url = "https://github.com/libyal/liblnk.git";
      rev = "86561ff0344931d500142bf12b4c9200023c42cb";
      sha256 = "sha256-cAP7pJjuO8Kn/PuT4aSEhkuf0xyNqMFSZZn8kQcx8fw=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];


    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfwps libfwsi libuna];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfwps libfwsi libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "Library to parse Windows Link Files (LNK) format";
      homepage = "https://github.com/libyal/liblnk/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
