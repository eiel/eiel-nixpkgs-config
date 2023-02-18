{
  description = "eiel's nix configuration";

  outputs = { self, nixpkgs }:
    let
      buildOutputs = system: {
        packages."${system}".default = self.packages."${system}".hello;
        formatter."${system}" = nixpkgs.legacyPackages.x86_64-darwin.nixpkgs-fmt;
      };
    in
    nixpkgs.lib.recursiveUpdate (buildOutputs "x86_64-darwin") (buildOutputs "aarch64-darwin");
}
