{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
, libcnotify
}:
stdenv.mkDerivation {
    name = "libmapidb";

    src = fetchgit {
      url = "https://github.com/libyal/libmapidb.git";
      rev = "79f64a6dce94de6b2e73220ebfa548e3fa0f8a01";
      hash = "sha256-IrclFLaQ478mNdhcUzfi6Kqa+1USdwqACPzadcui9S8=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror libcnotify
    ];

    preConfigure = ''
      for i in libcerror libcnotify ; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
