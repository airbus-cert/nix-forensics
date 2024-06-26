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
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfcache, libfdata, libfdatetime, libfguid, libfusn, libfwnt, libhmac, libuna
}:
stdenv.mkDerivation rec {
    name = "libfsntfs";

    src = fetchgit {
      url = "https://github.com/libyal/libfsntfs.git";
      rev = "d3025a995dbd66c6d3fe7b5e2dd4a2a970949daa";
      sha256 = "sha256-NbSEa/Vt+37oV21Q23JURO7gZ15eALmrnzQKK9bVWIU=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfusn libfwnt libhmac libuna];

    preConfigure = ''
      for i in  libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfusn libfwnt libhmac libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "Library and tools to access the Windows New Technology File System (NTFS)";
      homepage = "https://github.com/libyal/libfsntfs/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
