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
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfcache, libfdata, libfguid, libuna
}:
stdenv.mkDerivation rec {
    name = "libvhdi";

    src = fetchgit {
      url = "https://github.com/libyal/libvhdi.git";
      rev = "faea8523479ec0864fdf590f0b944a28424cee95";
      sha256 = "sha256-bkdvawYEWI5UzLK8gcZq+/L23z/vs9ORhT97eHbCk3s=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfguid libuna];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfguid libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "Library to access Virtual Hard Disk image (VHDI) format";
      homepage = "https://github.com/libyal/libvhdi/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
