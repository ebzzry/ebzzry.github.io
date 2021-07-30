with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "nix-shell";
  buildInputs = [ gnumake parallel-rust findutils emem ];
}
