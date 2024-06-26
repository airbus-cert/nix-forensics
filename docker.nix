{ dockerTools
, nixForensicsShell
}:
dockerTools.buildNixShellImage {
  drv = nixForensicsShell;
}
