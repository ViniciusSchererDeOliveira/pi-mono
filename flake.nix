{
  description = "pi-monorepo - AI coding agent and related packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  }

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_20
            nodePackages.npm
            git
          ];

          shellHook = ''
            export PATH="$PWD/node_modules/.bin:$PATH"

            if [ ! -d "node_modules" ]; then
              echo "Installing dependencies..."
              npm install
            fi
          '';
        };
      }
    );
}