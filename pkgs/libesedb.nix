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
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfcache, libfdata, libfdatetime, libfguid, libfmapi, libfvalue, libfwnt, libmapidb, libuna
}:
stdenv.mkDerivation rec {
    name = "libesedb";

    src = fetchgit {
      url = "https://github.com/libyal/libesedb.git";
      rev = "24ae2ff47365adb5f1dcdce315ac7dd16b972836";
      sha256 = "sha256-tTm16QCGQGD02f9Da7U1u/XM/EhVT9Hj1F18M3qxuC4=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfmapi libfvalue libfwnt libmapidb libuna];

    patchPhase = "for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfmapi libfvalue libfwnt libmapidb libuna; do true; sed -i \"/$i /d\" Makefile.am; sed -i \"/$i.Makefile/d\" configure.ac; done;";
    #patchPhase = ''
    #  for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfmapi libfvalue libfwnt libmapidb libuna; do
    #    sed -i "/$i /d" Makefile.am;
    #    sed -i "/$i\/Makefile/d" configure.ac;
    #  done:
    #'';

    preConfigure = ''
      autoreconf --install;
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "libesedb is a library to access the Extensible Storage Engine (ESE) Database File (EDB) format.";
      homepage = "https://github.com/libyal/libesedb/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
