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

            fzf
            jq

            tcpdump
            nmap
            gh

            delta

            nmap
            mtr

            google-cloud-sdk
            awscli2

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
            openssh
            unzip
            zip
          ];

          shellHook = "exec zsh";
        };
      };
}
