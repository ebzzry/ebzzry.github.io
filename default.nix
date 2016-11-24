with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "ttt";
    buildInputs = [ emem parallel gnumake ];
}
