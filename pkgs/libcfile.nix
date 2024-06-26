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
, libcnotify
, libuna
}:
stdenv.mkDerivation {
    name = "libcfile";

    src = fetchgit {
      url = "https://github.com/libyal/libcfile.git";
      rev = "538ec50e581a3b7e136ab0d1a3731b0475680450";
      hash = "sha256-vkgALQPSkIuSmNtVRx+7FXAJDBmXcNI7Tl+Q7A2cIrA=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
      libclocale
      libcnotify
      libcthreads
      libuna
    ];

    preConfigure = ''
      sed -i -e '/libuna/d' -e '/AC_CONFIG_FILES..libcdatetime.Makefile/d' -e '/AC_CONFIG_FILES..libcnotify.Makefile/d' -e '/AC_CONFIG_FILES..libclocale.Makefile/d' -e '/AC_CONFIG_FILES..libcerror.Makefile/d' -e '/AC_CONFIG_FILES..libcthreads.Makefile/d' configure.ac;
      sed -i -e '/libcerror /d' -e '/libcthreads /d' -e '/libcdatetime /d' -e '/libcnotify /d' -e '/libclocale /d' -e '/libuna /d' Makefile.am
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
