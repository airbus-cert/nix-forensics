{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfcache, libfdata, libfdatetime, libuna
}:
stdenv.mkDerivation {
    name = "libexe";

    src = fetchgit {
      url = "https://github.com/libyal/libexe.git";
      rev = "cab97184be54abde56fbaaddbe2c9147c9f9510c";
      hash = "sha256-Uk7xPgmlNgBaSGYZUyzExrSkzEL3BPDwqealk6317jI=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libuna
    ];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
