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
, libbfio, libcdata, libcdirectory, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libexe, libfcache, libfdata, libfdatetime, libfguid, libfvalue, libfwevt, libfwnt, libregf, libuna, libwrc
}:
stdenv.mkDerivation rec {
    name = "libevtx";

    src = fetchgit {
      url = "https://github.com/libyal/libevtx.git";
      rev = "d028b4f90886d467b2960b69084aa2485d7e218b";
      sha256 = "sha256-XXYOFE3kYaC33j21kDO89MpJeNgU1NYxTCDfjmognpc=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    buildInputs = [ fuse python3 libbfio libcdata libcdirectory libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwevt libfwnt libregf libuna libwrc];

    preConfigure = ''
      for i in libbfio libcdata libcdirectory libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwevt libfwnt libregf libuna libwrc; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "Library and tools to access the Windows XML Event Log (EVTX) format";
      homepage = "https://github.com/libyal/libevtx/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
