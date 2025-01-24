{
  description = "A ❄️️";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      user = "ebzzry";
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
      devShells.${system} = {
        default = mkShell {
          buildInputs = [ gnumake parallel findutils emem screen python3 ];
          LD_LIBRARY_PATH = nixpkgs.lib.strings.makeLibraryPath [ ];
        };
      };
    };
}
