{ pkgs ? import <nixpkgs> { inherit system; },
  system ? builtins.currentSystem }:

let
  nodePackages = import ./puppet-nix {
    inherit pkgs system;
  };
  python-env = import ./hangups-nix/requirements.nix {
    inherit pkgs;
  };
in
nodePackages."matrix-puppet-hangouts-git://github.com/matrix-hacks/matrix-puppet-hangouts.git".override {
  buildInputs = [ pkgs.makeWrapper ];
  propagatedBuildInputs = [ python-env.interpreter ];
  postInstall = ''
    wrapProgram $out/bin/matrix-puppet-hangouts --prefix PATH : "${python-env.interpreter}/bin"
  '';
  patches = [ ./0001-produce-executable.patch ];
}
