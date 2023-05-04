{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
  # packages are just installed (no configuration applied)
  # programs are installed and configuration applied to dotfiles
  # add your personalized program configuration in ./user.nix

  # Bling supplied programs

  # User specified programs
    programs.dircolors.enable = true;

    programs.exa.enable = true;
    programs.bat.enable = true;
    programs.atuin.enable = true;
    programs.zoxide.enable = true;
    programs.direnv.enable = true;
    programs.starship.enable = true;
    programs.zsh.oh-my-zsh.enable = true;
    programs.neovim.enable = true;
    programs.gpg.enable = true;

}
