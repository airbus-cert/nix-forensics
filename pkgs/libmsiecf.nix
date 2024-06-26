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
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfdatetime, libfguid, libfole, libfvalue, libuna
}:
stdenv.mkDerivation rec {
    name = "libmsiecf";

    src = fetchgit {
      url = "https://github.com/libyal/libmsiecf.git";
      rev = "c4ca01ebaca0a2cbecba5136f6db1660f86a4008";
      sha256 = "sha256-v+NPNiNXBdEzn1YobksXPnkc/gzMPeuHUnSqZuXuqxA=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];


    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfvalue libuna];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfvalue libuna; do
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
