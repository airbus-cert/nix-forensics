{ stdenv
, fetchgit
, automake
, autoconf
, libtool
, pkg-config
, gettext
, libbfio, libcdata, libcerror, libcfile, libclocale, libcnotify, libcpath, libcsplit, libcthreads, libfcache, libfdata, libfdatetime, libfwnt, libuna
}:
stdenv.mkDerivation {
    name = "libregf";

    src = fetchgit {
      url = "https://github.com/libyal/libregf.git";
      rev = "51edeb225ffcaf6f9f3b27248eafc67f6d07ba84";
      hash = "sha256-2yzW7WmR7j3HExKt0ZnWoMh1gqvsy2Ai7SKlBbJtGBk=";
    };

    nativeBuildInputs = [
      automake
      autoconf
      libtool
      pkg-config
      gettext
      libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfwnt libuna
    ];

    preConfigure = ''
      for i in libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfwnt libuna; do
        sed -i "/$i/d" Makefile.am configure.ac;
      done;
      autoreconf --install
    '';

    buildInputs = [
    ];

    configureFlags = [];
}
