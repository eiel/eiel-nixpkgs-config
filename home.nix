username: {
  config,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

  home.sessionVariables = {
    EDITOR = "emacsclient";
  };

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
    pkgs.gopls
    pkgs.gron
    pkgs.jq
    pkgs.lsd
    pkgs.peco
    pkgs.ripgrep
    pkgs.rnix-lsp
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/Users/${username}";
  home.stateVersion = "23.05";
}
