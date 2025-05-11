{ nixpkgs, pkgs, ... }:
with pkgs;
rec {
  www = mkShell {
    buildInputs = [
      emem
      gnumake
      gnused
      parallel
      findutils
      screen
      python3
    ];
  };
  default = www;
}
