{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
, libcthreads
, libclocale
, libcsplit
, libuna
}:
stdenv.mkDerivation {
    name = "libcpath";

    src = fetchgit {
      url = "https://github.com/libyal/libcpath.git";
      rev = "fcc7645b094e904cfb57ce5eb9e7515ad12b420f";
      hash = "sha256-/CTGqIxbrBvwc8g0txhBzprT9QJdfuTtBgl4eDdH20o=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
      libclocale
      libcthreads
      libuna
      libcsplit
    ];

    preConfigure = ''
      sed -i -e '/libcsplit/d' -e '/libuna/d' -e '/AC_CONFIG_FILES..libcdatetime.Makefile/d' -e '/AC_CONFIG_FILES..libcnotify.Makefile/d' -e '/AC_CONFIG_FILES..libclocale.Makefile/d' -e '/AC_CONFIG_FILES..libcerror.Makefile/d' -e '/AC_CONFIG_FILES..libcthreads.Makefile/d' configure.ac;
      sed -i -e '/libcsplit/d' -e '/libcerror /d' -e '/libcthreads /d' -e '/libcdatetime /d' -e '/libcnotify /d' -e '/libclocale /d' -e '/libuna /d' Makefile.am
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
