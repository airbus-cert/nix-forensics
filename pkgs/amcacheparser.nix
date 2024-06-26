{ fetchFromGitHub
, buildDotnetModule
, git
, dotnetCorePackages
}:
let
  pname = "AmcacheParser";
  version = "1.2.0";
in
buildDotnetModule {
  inherit pname version;  

  src = fetchFromGitHub {
    owner = "EricZimmerman";
    repo = pname;
    rev = version;
    leaveDotGit = true;

    hash = "sha256-bQ7bUF9HI+5sloX51RwJe2HNoJn7EOdkR/3KKFy1JHk=";
  };
 
  dotnet-sdk = dotnetCorePackages.sdk_6_0;
  dotnet-runtime = dotnetCorePackages.runtime_6_0;

  dotnetFlags = "--property:Deterministic=false --property:GenerateAssemblyInfo=false --property:TargetFramework=net6.0";

  nativeBuildInputs = [
    git
  ];

  projectFile = "AmcacheParser.sln";
  nugetDeps = ./amcacheparser-deps.nix;
}
