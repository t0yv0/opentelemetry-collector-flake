{
  description = "A flake defining opentelemetry-collector  package via GitHub sources build";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-22.05;
    opentelemetry-collector-src = {
      url = "github:open-telemetry/opentelemetry-collector/v0.54.0";
      flake = false;
    };
  };

  outputs =
    { self,
      nixpkgs,
      opentelemetry-collector-src
    }:

    let
      ver = "0.54.0";

      package = { system }:
        let
          pkgs = import nixpkgs { system = system; };
        in pkgs.buildGoModule rec {
          name = "opentelemetry-collector-${ver}";
          version = "${ver}";
          src = opentelemetry-collector-src;
          modRoot = "cmd/otelcorecol";
          vendorSha256 = "SkOyDaECWKxJjB7KVht1XXMKcLm8NSqzYTZEW25WFyE=";
         };
    in {
      packages.x86_64-linux.default = package {
        system = "x86_64-linux";
      };
      packages.x86_64-darwin.default = package {
        system = "x86_64-darwin";
      };
    };
}
