{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata, libcerror, libclocale, libcnotify, libcthreads, libfdatetime, libfguid, libfole, libfwps, libuna 
}:
stdenv.mkDerivation {
    name = "libfwsi";

    src = fetchgit {
      url = "https://github.com/libyal/libfwsi.git";
      rev = "2e9e2a7bbd983a516e07792dc1cb97078038c82f";
      hash = "sha256-H7QjFaYw0DEUz41N84sBlCR6mUf842BZMTl3v7o/6mE=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
      libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libfole libfwps libuna
    ];

    preConfigure = ''
      for i in libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libfole libfwps libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
