{ stdenv }:
let
  gitDetails = builtins.fromJSON (builtins.readFile ./matrix-puppet-hangouts.json);
  puppetSrc = fetchGit {
    inherit (gitDetails) url rev;
  };
in stdenv.mkDerivation {
  name = "matrix-puppet-hangouts";
  src = puppetSrc;
  phases = [];
}
