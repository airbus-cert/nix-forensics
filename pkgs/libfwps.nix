{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata, libcerror, libclocale, libcnotify, libcthreads, libfdatetime, libfguid, libuna
}:
stdenv.mkDerivation {
    name = "libfwps";

    src = fetchgit {
      url = "https://github.com/libyal/libfwps.git";
      rev = "59b146c655364cab66b1230348aee1f48be48000";
      hash = "sha256-t6+T1UWjsnM/bMiCSMP2pLthTDjmrEJuy9/oR38XI/c=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
      libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libuna
    ];

    preConfigure = ''
      for i in libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
