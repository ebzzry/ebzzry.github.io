{
  description = "🕸️❄️️";
  inputs = { nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
  outputs = { self, nixpkgs, ... }@inputs:
    let
      user = builtins.getEnv "USER";
      system = builtins.currentSystem;
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
