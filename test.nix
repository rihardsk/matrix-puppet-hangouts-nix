{ pkgs ? import <nixpkgs> {} }:
let
  configJson = builtins.toFile "config.json" ''
    {
      "registrationPath": "hangouts-registration.yaml",
      "port": 8090,
      "bridge": {
        "homeserverUrl": "https://your-home-server.example.org",
        "domain": "example.org",
        "registration": "hangouts-registration.yaml"
      }
    }
  '';
in pkgs.callPackage ./default.nix { inherit configJson; }
