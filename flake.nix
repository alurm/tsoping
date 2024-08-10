{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      name = "tsoping";
      tsoping = (
        pkgs.writeScriptBin name (builtins.readFile ./tsoping)
      ).overrideAttrs(old: {
        buildCommand = "${old.buildCommand}\n patchShebangs $out";
      });
    in rec {
      packages.tsoping = pkgs.symlinkJoin {
        inherit name;
        paths = [
          tsoping pkgs.python312Packages.xmljson pkgs.jq pkgs.curl pkgs.coreutils
        ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
      };
    }) // {
      nixosModules.tsoping = import ./module.nix self;
    }
  ;
}
