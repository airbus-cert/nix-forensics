{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
, libcthreads
, libcnotify
, libcdatetime
, libclocale
}:
stdenv.mkDerivation {
    name = "libuna";

    src = fetchgit {
      url = "https://github.com/libyal/libuna.git";
      rev = "ee21db63eed2820396cff0a7442e408c028535f2";
      hash = "sha256-/05CPauv76UEflFs8JG7KnVUrh1/XSaDUBoAHjg0zoY";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
      libcthreads
      libcnotify
      libclocale
      libcdatetime
    ];

    preConfigure = ''
      rm -fr unatools;
      sed -i -e '/unatools/d' -e '/AC_CONFIG_FILES..libcdatetime.Makefile/d' -e '/AC_CONFIG_FILES..libcnotify.Makefile/d' -e '/AC_CONFIG_FILES..libclocale.Makefile/d' -e '/AC_CONFIG_FILES..libcerror.Makefile/d' -e '/AC_CONFIG_FILES..libcthreads.Makefile/d' -e '/AC_CONFIG_FILES..libcfile.Makefile/d' configure.ac;
      sed -i -e '/libcerror /d' -e '/libcthreads /d' -e '/libcdatetime /d' -e '/libcnotify /d' -e '/libclocale /d' -e '/libcfile /d' -e '/unatools/d' Makefile.am
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
