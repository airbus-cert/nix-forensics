{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata, libcerror, libcnotify, libcthreads
}:
stdenv.mkDerivation {
    name = "libfwnt";

    src = fetchgit {
      url = "https://github.com/libyal/libfwnt.git";
      rev = "24d81387a2c8bbabad5e787e75967039e8bfae29";
      hash = "sha256-CSoy4GwIYODN8ybQNbeOePmabl2WP99ebMoQkZlS6Io=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcdata libcerror libcnotify libcthreads
    ];

    preConfigure = ''
      for i in libcdata libcerror libcnotify libcthreads; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
      sed -n '48,54p' libfwnt/libfwnt_locale_identifier.h >> include/libfwnt.h.in
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
