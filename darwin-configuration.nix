{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];
  users.users.eiel = {
    name = "eiel";
    home = "/Users/eiel";
  };
  home-manager.users.eiel = { pkgs, ... }: {
    home.packages = [ pkgs.vim pkgs.git pkgs.gh ];
    programs.fish.enable = true;
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [ epkgs.magit epkgs.nix-mode ];
    };
    home.stateVersion = "23.05";
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;  # default shell on catalina

  homebrew.enable = true;
  homebrew.taps = ["homebrew/cask-versions"];
  homebrew.casks = [
      "1password"
      "karabiner-elements"
      "firefox-beta"
      "google-chrome-beta"
    ];

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
