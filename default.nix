# nixos-23.11 - 2023-12-19
{ pkgs ? (import (fetchTarball "https://github.com/nixos/nixpkgs/archive/1e2e384c5b7c50dbf8e9c441a9e58d85f408b01f.tar.gz") {})}:
with pkgs;
rec {
  my-python-registry = python3Packages.python-registry.overridePythonAttrs {
    src = fetchFromGitHub {
      owner = "nbareil";
      repo = "python-registry";
      rev = "f4cddbc4ce77b0ca3682474e10d130c624a96349";
      hash = "sha256-CUOC3UxgD7zUf0OmOh4fpa/oqKsT3hkr4ZGHHKCA/nQ=";
    };
  };


  libcerror = callPackage ./pkgs/libcerror.nix {};
  libcthreads = callPackage ./pkgs/libcthreads.nix { inherit libcerror; };
  libcnotify = callPackage ./pkgs/libcnotify.nix { inherit libcerror; };
  libcdatetime = callPackage ./pkgs/libcdatetime.nix { inherit libcerror; };
  libcsplit = callPackage ./pkgs/libcsplit.nix { inherit libcerror; };
  libclocale = callPackage ./pkgs/libclocale.nix { inherit libcerror; };
  libcdata  = callPackage ./pkgs/libcdata.nix  { inherit libcerror libcthreads; };
  libuna  = callPackage ./pkgs/libuna.nix  { inherit libcerror libcthreads libcnotify libcdatetime libclocale;  };
  libcfile  = callPackage ./pkgs/libcfile.nix  { inherit libcerror libcthreads libuna libclocale libcnotify; };
  libcpath  = callPackage ./pkgs/libcpath.nix  { inherit libcerror libcthreads libuna libclocale libcsplit; };
  libbfio  = callPackage ./pkgs/libbfio.nix  { inherit libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna; };
  libfcache = callPackage ./pkgs/libfcache.nix { inherit libcdata libcerror libcthreads; };
  libfdata = callPackage ./pkgs/libfdata.nix { inherit libcdata libcerror libcnotify libcthreads libfcache; };
  libfdatetime = callPackage ./pkgs/libfdatetime.nix { inherit libcerror; };
  libfguid = callPackage ./pkgs/libfguid.nix { inherit libcerror; };
  libfusn = callPackage ./pkgs/libfusn.nix { inherit libcerror libcnotify libfdatetime libuna; };
  libfwnt = callPackage ./pkgs/libfwnt.nix { inherit libcdata libcerror libcnotify libcthreads; };
  libhmac = callPackage ./pkgs/libhmac.nix { inherit libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libuna; };
  libfsntfs = callPackage ./pkgs/libfsntfs.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfusn libfwnt libhmac libuna; };
  libfmapi = callPackage ./pkgs/libfmapi.nix { inherit libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna; };
  libfvalue = callPackage ./pkgs/libfvalue.nix { inherit libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna ; };
  libmapidb = callPackage ./pkgs/libmapidb.nix { inherit libcerror libcnotify; };
  libesedb = callPackage ./pkgs/libesedb.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfguid libfmapi libfvalue libfwnt libmapidb libuna; };
  libvshadow = callPackage ./pkgs/libvshadow.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libuna;};
  libcdirectory = callPackage ./pkgs/libcdirectory.nix { inherit libcerror libclocale libuna; };
  libexe = callPackage ./pkgs/libexe.nix { inherit libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libuna; };
  libfwevt = callPackage ./pkgs/libfwevt.nix { inherit libcdata libcerror libcnotify libcthreads libfdatetime libfguid libfwnt libuna; };
  libregf = callPackage ./pkgs/libregf.nix { inherit libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfdatetime libfwnt libuna; };
  libwrc = callPackage ./pkgs/libwrc.nix { inherit libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwnt libuna; };
  libevtx = callPackage ./pkgs/libevtx.nix { inherit fuse python3 libbfio libcdata libcdirectory libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libexe libfcache libfdata libfdatetime libfguid libfvalue libfwevt libfwnt libregf libuna libwrc;};
  libvmdk = callPackage ./pkgs/libvmdk.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfvalue libuna;};
  libvhdi = callPackage ./pkgs/libvhdi.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfcache libfdata libfguid libuna;};
  libfole = callPackage ./pkgs/libfole.nix { inherit libcerror; };
  libmsiecf = callPackage ./pkgs/libmsiecf.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfvalue libuna;};
  libfwps = callPackage ./pkgs/libfwps.nix { inherit libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libuna; };
  libfwsi = callPackage ./pkgs/libfwsi.nix { inherit libcdata libcerror libclocale libcnotify libcthreads libfdatetime libfguid libfole libfwps libuna; };
  liblnk = callPackage ./pkgs/liblnk.nix { inherit fuse python3 libbfio libcdata libcerror libcfile libclocale libcnotify libcpath libcsplit libcthreads libfdatetime libfguid libfole libfwps libfwsi libuna;};

  shellbags = ps: callPackage ./pkgs/shellbags.nix {  python2Packages = ps; };
  INDXParse = callPackage ./pkgs/INDXParse.nix {};
  INDXRipper = callPackage ./pkgs/INDXRipper.nix {};
  dfir_ntfs = callPackage ./pkgs/dfir_ntfs.nix {};
  yarp = callPackage ./pkgs/yarp.nix {};
  cimlib = callPackage ./pkgs/cimlib.nix {};
  shimCacheParser = callPackage ./pkgs/shimCacheParser.nix {};
  #mftspy = callPackage ./pkgs/mftspy.nix { inherit libfsntfs; };
  regrippy = callPackage ./pkgs/regrippy.nix {};
  regipy = callPackage ./pkgs/regipy.nix { inherit libfwsi; };
  netstructlib = callPackage ./pkgs/netstructlib.nix {};
  CobaltStrikeParser = callPackage ./pkgs/CobaltStrikeParser.nix { inherit netstructlib; };
  domaintoolslib = callPackage ./pkgs/domaintoolslib.nix {};
  pymisplib = callPackage ./pkgs/pymisplib.nix {};
  splunklib = callPackage ./pkgs/splunklib.nix {};
  pdoclib = callPackage ./pkgs/pdoclib.nix {};
  huntlib = callPackage ./pkgs/huntlib.nix { inherit splunklib domaintoolslib pymisplib; };
  evtxTools = callPackage ./pkgs/evtxTools.nix {};
  usnrs = callPackage ./pkgs/usnrs.nix {};
  liblnk-python = python3Packages.toPythonModule liblnk;
  timeliner = callPackage ./pkgs/timeliner.nix {};
  libevtx-python = python3Packages.toPythonModule libevtx;
  #srum-dump = callPackage ./pkgs/srum-dump.nix { inherit libesedb; };
  amcacheparser = callPackage ./pkgs/amcacheparser.nix {};
  bits_parser = callPackage ./pkgs/bits_parser.nix {};
  at_jobs_carver = callPackage ./pkgs/at_jobs_carver.nix {};
  ccm_rua_finder = callPackage ./pkgs/ccm_rua_finder.nix {};
  registryFlush = python3Packages.callPackage ./pkgs/registryFlush.nix { inherit yarp; };
  forensicslab = callPackage ./pkgs/forensicslab.nix {};

  customPython = pkgs.python3.withPackages (ps: with ps; [
      requests
      python_magic
      grpcio
      dateutil
      pandas
      requests_ntlm
      google-api-python-client
      pandas
      pytest-vcr

      jinja2
      lxml
      yara-python
      fuse
      evtx
      progressbar
    ]
    ++  [
      pdoclib
      huntlib
      splunklib
      pytest
      libevtx-python
      liblnk-python
    ]);


    docker = callPackage ./docker.nix { nixForensicsShell = import ./shell.nix; };
}
