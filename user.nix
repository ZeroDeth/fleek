{ pkgs, misc, ... }: {
  # FEEL FREE TO EDIT: This file is NOT managed by fleek.
  # configs mentioned here must be listed in ~/fleek.yml #programs array or you will get errors
  # home manager options available here: https://nix-community.github.io/home-manager/options.html

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.exa = {
    enableAliases = true;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };

  programs.bat.config = {
    theme = "TwoDark";
  };

  programs.neovim = {
    viAlias = true;
    vimAlias = true;
  };

}
