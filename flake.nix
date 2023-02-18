{
  description = "eiel's nix configuration";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      systemPackages = system: nixpkgs.legacyPackages."${system}";
      selectDerivationAllSupportedSystems = selector: forAllSystems (system: selector (systemPackages system));
    in
    {
      packages = selectDerivationAllSupportedSystems (pkgs: { default = pkgs.hello; });
      formatter = selectDerivationAllSupportedSystems (pkgs: pkgs.nixpkgs-fmt);
    };
}
