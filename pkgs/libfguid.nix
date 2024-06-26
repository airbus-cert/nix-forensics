{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcerror
}:
stdenv.mkDerivation {
    name = "libfguid";

    src = fetchgit {
      url = "https://github.com/libyal/libfguid.git";
      rev = "c79feddbafec7d24df8c661e8c9be1417d4dedf4";
      hash = "sha256-/D7cb28SEyOcgwJVahmuYxmPf54ioLXKIjZFfKQgEmY";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcerror
    ];

    preConfigure = ''
      for i in libcerror; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
