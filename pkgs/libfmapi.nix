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
    name = "libfmapi";

    src = fetchgit {
      url = "https://github.com/libyal/libfmapi.git";
      rev = "a35168bc8695fac44d5dc665926848bfc8d58ca6";
      hash = "sha256-CWgK0Ze2d7J8w/ac3KCwAlOOiZdNUk9LHo6+K9/7yno=";
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
