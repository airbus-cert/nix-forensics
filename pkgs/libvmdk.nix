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
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfcache, libfdata, libfvalue, libuna
}:
stdenv.mkDerivation rec {
    name = "libvmdk";

    src = fetchgit {
      url = "https://github.com/libyal/libvmdk.git";
      rev = "34890e3d1cb34b06502ec789fbea764d38817207";
      sha256 = "sha256-FKgwPgFeGtX9lbbTHaPUwgDqje5Yw5QQhcvwgUK9xXQ=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfvalue libuna];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfvalue libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "Library to access the VMWare disk (VMDK) format";
      homepage = "https://github.com/libyal/libvmdk/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
