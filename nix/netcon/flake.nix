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
	          (google-cloud-sdk.withExtraComponents [
              google-cloud-sdk.components.gke-gcloud-auth-plugin
	          ])
	          kubectl
          ];

          shellHook = "exec zsh";
        };
      };
}
