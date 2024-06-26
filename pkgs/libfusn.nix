{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
, libcnotify
, libfdatetime
, libuna
}:
stdenv.mkDerivation {
    name = "libfusn";

    src = fetchgit {
      url = "https://github.com/libyal/libfusn.git";
      rev = "6eaa6acc2bc0928d430f3f12e0dcb7ad5819e04d";
      hash = "sha256-YmAokCOAwpwe5PaHtNg/jMc/j8K2wFCNntU7MDFbzWQ=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror libcnotify libfdatetime libuna
    ];

    preConfigure = ''
      for i in libcerror libcnotify libfdatetime libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
