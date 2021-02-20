{
  description = "Your flake using poetry2nix";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.utils.url = "github:numtide/flake-utils";
  inputs.poetry2nix-src.url = "github:nix-community/poetry2nix";

  outputs = { nixpkgs, utils, poetry2nix-src, self }: utils.lib.eachDefaultSystem (system:
    let

      pkgs = import nixpkgs {
        inherit system; overlays = [
        poetry2nix-src.overlay
      ];

      };

    in
    {
      defaultPackage = pkgs.poetry2nix.mkPoetryApplication {
        python = pkgs.python39;
        projectDir = ./.;
      };
    });
}
