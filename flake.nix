{
  description = "🕸️❄️️";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in with pkgs; {
      devShells.${system} = {
        default = mkShell {
          buildInputs = [ bash gnumake parallel findutils emem screen python3 ];
          LD_LIBRARY_PATH = nixpkgs.lib.strings.makeLibraryPath [ ];
        };
      };
    };
}
