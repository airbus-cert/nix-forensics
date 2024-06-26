{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libuna
}:
stdenv.mkDerivation {
    name = "libhmac";

    src = fetchgit {
      url = "https://github.com/libyal/libhmac.git";
      rev = "7ce99ac975e27be8e19eea9accf5ffce0304fe8a";
      hash = "sha256-d3q3YPt0E1ogsWwpz1MJCRIW0l/Q7GVeHJNsVn2ihYk=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna
    ];

    preConfigure = ''
      for i in libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
