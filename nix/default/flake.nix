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
            zsh starship sheldon

            git
            vim neovim

            zoxide
            direnv

            pet

            fzf
            jq
	    yq
            go

            gh

            delta

            pueue

            ripgrep

            uv

            wget

            watch

            # Common utilities installed by default on macOS
            # Here is defined to override the default version
            coreutils
            gawk
            gnugrep
            gnused
            gnutar
            inetutils
            openssh_gssapi
            unzip
            zip
          ];

          shellHook = "exec zsh";
        };
      };
}
