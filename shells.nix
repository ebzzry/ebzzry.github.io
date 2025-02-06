{ nixpkgs, pkgs, ... }:
with pkgs; rec {
  www = mkShell {
    buildInputs = [ bash gnumake parallel findutils emem screen python3 ];
  };
  default = www;
}
