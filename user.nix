{ pkgs, misc, ... }: {
  # FEEL FREE TO EDIT: This file is NOT managed by fleek.
  # configs mentioned here must be listed in ~/fleek.yml #programs array or you will get errors
  # home manager options available here: https://nix-community.github.io/home-manager/options.html

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs = {
    exa = {
      enableAliases = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    bat = {
      # Better 'cat'
      # enable = true;
      config = {
        theme = "TwoDark";
        italic-text = "always";
        pager = "less -FR";
      };
    };

    neovim = {
      viAlias = true;
      vimAlias = true;
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };

    # This makes it so that if you type the name of a program that
    # isn't installed, it will tell you which package contains it.
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };
  };

}
