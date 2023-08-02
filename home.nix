{ config, pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
  nixpkgs = {
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
      
      
      allowBroken = true;
      
    };
  };

  
  # managed by fleek, modify ~/.fleek.yml to change installed packages
  
  # packages are just installed (no configuration applied)
  # programs are installed and configuration applied to dotfiles
  home.packages = [
    # user selected packages
    pkgs.helix
    pkgs.gtop
    pkgs.nodejs-18_x
    pkgs.yarn
    pkgs.go
    pkgs.gopls
    pkgs.duf
    pkgs.ctop
    pkgs.kitty
    pkgs.git
    pkgs.htop
    pkgs.glab
    pkgs.fzf
    pkgs.ripgrep
    pkgs.vscode
    pkgs.lazygit
    pkgs.jq
    pkgs.yq
    pkgs.neofetch
    pkgs.btop
    pkgs.cheat
    pkgs.gnupg
    pkgs.pinentry_mac
    pkgs.python3
    pkgs.pre-commit
    pkgs.chezmoi
    pkgs.shellcheck
    pkgs.cachix
    pkgs.fish
    pkgs.thefuck
    pkgs.byobu
    pkgs.docker
    pkgs.colima
    pkgs.alacritty
    pkgs.iterm2
    pkgs.chatgpt-cli
    pkgs.lima
    pkgs.tmux
    pkgs.tree
    pkgs.tree-sitter
    pkgs.nix-index
    pkgs.topgrade
    pkgs.trash-cli
    pkgs.wezterm
    pkgs.devbox
    pkgs.prettyping
    # Fleek Bling
    pkgs.git
    pkgs.htop
    pkgs.github-cli
    pkgs.glab
    pkgs.fzf
    pkgs.ripgrep
    pkgs.vscode
    pkgs.lazygit
    pkgs.jq
    pkgs.yq
    pkgs.neofetch
    pkgs.btop
    pkgs.cheat
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  fonts.fontconfig.enable = true; 
  home.stateVersion =
    "22.11"; # To figure this out (in-case it changes) you can comment out the line and see what version it expected.
  programs.home-manager.enable = true;
}
