{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata
, libcerror
, libcnotify
, libcthreads
, libfcache
}:
stdenv.mkDerivation {
    name = "libfdata";

    src = fetchgit {
      url = "https://github.com/libyal/libfdata.git";
      rev = "c7d92a0ab2dd665fb328e0aa637ca7d04cfcf46c";
      hash = "sha256-trfw1FtzQlDvXIvrRk3eGbI6ty+9M6YeK79aePsNtPU=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcdata libcerror libcnotify libcthreads libfcache
    ];

    preConfigure = ''
      for i in libcdata libcerror libcnotify libcthreads libfcache; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
