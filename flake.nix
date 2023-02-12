{
  description = "eiel's nix configuration";

  outputs = { self, nixpkgs }:
    let system = "x86_64-darwin";
    in {
      packages."${system}".default = self.packages."${system}".hello;
      formatter."${system}" = nixpkgs.legacyPackages.x86_64-darwin.nixpkgs-fmt;
    };
}
