{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libcdata, libcerror, libcnotify, libcthreads, libfdatetime, libfguid, libfwnt, libuna
}:
stdenv.mkDerivation {
    name = "libfvalue";

    src = fetchgit {
      url = "https://github.com/libyal/libfvalue.git";
      rev = "39f3b0200826fd7b43aeb40566ac173afed7890a";
      hash = "sha256-/uxawYW+tKFor8Ph9UGRLMQcKamoczCYa0cp2QCvh4I=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna
    ];

    preConfigure = ''
      for i in libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autopoint --force
      aclocal --force --install -I m4
      libtoolize --force
      autoheader --force
      autoreconf --force --install
      automake --force --add-missing
      sed -n '341,$p' libfvalue/libfvalue_value.h|grep -v '^[}#]' >> include/libfvalue.h.in
      sed -ne '88,189p' libfvalue/libfvalue_data_handle.h >> include/libfvalue.h.in
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
