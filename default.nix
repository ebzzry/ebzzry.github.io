with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "ttt";
    buildInputs = [ gnumake parallel findutils emem ];
}
