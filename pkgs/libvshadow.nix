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
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfdatetime, libfguid, libuna
}:
stdenv.mkDerivation rec {
    name = "libvshadow";

    src = fetchgit {
      url = "https://github.com/libyal/libvshadow.git";
      rev = "2b39948515d8351223da000cbf4f2352578311c5";
      sha256 = "sha256-43HOE7QjrcwtzKcVViAY0spFapNXJXvBjXv0u3QMbbE=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
    ];

    buildInputs = [ fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libuna];

    preConfigure = ''
      for i in  libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    configureFlags = [ "--enable-python" ];

    meta = with lib; {
      description = "Library to access Volume Shadow Snapshot (VSS) format";
      homepage = "https://github.com/libyal/libvshadow/";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  }
