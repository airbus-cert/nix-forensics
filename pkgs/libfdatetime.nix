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
    name = "libfdatetime";

    src = fetchgit {
      url = "https://github.com/libyal/libfdatetime.git";
      rev = "133ca426176073d54f4e5eb1f7f61a39e0050fe2";
      hash = "sha256-ou9lveu8Z+MGGkUTaHBmHNJynJ/O/5Abdr/NyHeYMcU=";
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
