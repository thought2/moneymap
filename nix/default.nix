{ pkgs ? import <nixpkgs> {} }:
let
  nodePkg = (
      import ./node2nix/default.nix { inherit pkgs; nodejs = pkgs."nodejs-10_x"; }
    ).package;

  # TODO: Remove, once they're on nixos stable channel
  elmTools = import (pkgs.fetchFromGitHub {
    owner = "turboMaCk";
    repo = "nix-elm-tools";
    rev = "41b5045587f84d993a7ee55972cfd61152cafc48";
    sha256 = "1ns02xxj3zijf6myaxk8azgs8v69gpc2b0v080m2xjf1pvv6hd75";
  }) { inherit pkgs; };

in pkgs.stdenv.mkDerivation rec {
  name = "moneymap";
  src = pkgs.lib.cleanSource ./..;

  doCheck = true;

  buildInputs = with pkgs.elmPackages; [
    elm
    elm-format
    elmTools.elm-verify-examples
    elmTools.elm-test
  ];

  patchPhase = ''
    # Link `node_modules`
    rm -rf node_modules
    ln -sf ${nodePkg}/lib/node_modules/${name}/node_modules .

    # Create `.elm`
    rm -rf elm-stuff
    ${pkgs.elmPackages.fetchElmDeps {
      elmPackages = import ./elm2nix/elm-srcs.nix;
      versionsDat = ./elm2nix/versions.dat;
    }}
  '';

  installPhase = ''
    mkdir -p $out
    cp -r dist/* $out
  '';

  shellHook = patchPhase;
}
