{
  config,
  pkgs,
  ...
}: let
  user = import ./user.nix;
in {
  imports = [<home-manager/nix-darwin>];
  users.users = {
    "${user.name}" = {
      name = user.name;
      home = "/Users/${user.name}";
    };
  };
  home-manager.users."${user.name}" = {pkgs, ...}: {
    home.packages = [
      pkgs.aspell
      pkgs.aspellDicts.en
      pkgs.aspellDicts.en-computers
      pkgs.cachix
      pkgs.cloc
      pkgs.coreutils
      pkgs.delta
      pkgs.diffr
      pkgs.fd
      pkgs.gh
      pkgs.ghq
      pkgs.git
      pkgs.gron
      pkgs.jq
      pkgs.lsd
      pkgs.peco
      pkgs.ripgrep
      pkgs.xh
      pkgs.tig
      pkgs.tree
      pkgs.vim
    ];
    programs.fish.enable = true;
    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.consult
        epkgs.flycheck
        epkgs.forge
        epkgs.nix-mode
        epkgs.magit
        epkgs.marginalia
        epkgs.orderless
        epkgs.vertico
      ];
      extraConfig = ''
        (vertico-mode)

        (setq completion-styles '(orderless basic)
              completion-in-region-function #'consult-completion-in-region
              completion-category-defaults nil
              completion-category-overrides '((file (styles partial-completion))))
      '';
    };
    programs.git = {
      enable = true;
      userEmail = "eiel.hal@gmail.com";
      userName = "HIMURA Tomohiko a.k.a eiel";
      ignores = let
        direnv = [".envrc" ".direnv"];
        emacs = ["*~"];
      in
        direnv ++ emacs;
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

  security.pam.enableSudoTouchIdAuth = true;

  nix.settings = {
    extra-experimental-features = ["nix-command" "flakes"];
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;  # default shell on catalina

  homebrew.enable = true;
  homebrew.taps = ["homebrew/cask-versions"];
  homebrew.casks = [
    "1password"
    "karabiner-elements"
    "firefox-beta"
    "google-chrome-beta"
    "google-japanese-ime"
  ];

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 12;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
