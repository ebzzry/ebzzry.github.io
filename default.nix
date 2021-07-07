with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "ebzzry.github.io";
  buildInputs = [ gnumake parallel-rust findutils emem ];
}
