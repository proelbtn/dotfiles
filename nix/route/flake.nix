{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/24.11-beta";
    };
  };

  outputs =
    { nixpkgs, ... }:
      let
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      in
      {
        devShells.aarch64-darwin.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            awscli2
	    ssm-session-manager-plugin
          ];

          shellHook = "exec zsh";
        };
      };
}
