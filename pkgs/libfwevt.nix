{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata, libcerror, libcnotify, libcthreads, libfdatetime, libfguid, libfwnt, libuna
}:
stdenv.mkDerivation {
    name = "libfwevt";

    src = fetchgit {
      url = "https://github.com/libyal/libfwevt.git";
      rev = "18edea0655cb08cb778120248c0ca61a013e6874";
      hash = "sha256-QSFbd4LRUg8gq0sTqraG5QbGwpR5DRWy4OD0clijmek=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna
    ];

    preConfigure = ''
      for i in libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
