with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "ebzzry.io";
  buildInputs = [ gnumake parallel findutils emem ];
}
