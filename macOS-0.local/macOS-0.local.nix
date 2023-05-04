{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
    home.username = "zerodeth";
    home.homeDirectory = "/Users/zerodeth";

  #   programs.git = {
  #       enable = true;
  #       aliases = {
  #           pushall = "!git remote | xargs -L1 git push --all";
  #           graph = "log --decorate --oneline --graph";
  #           add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
  #           prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";

  #       };
  #       userName = "Sherif Abdalla";
  #       userEmail = "sherif@abdalla.uk";
  #       extraConfig = {
  #           feature.manyFiles = true;
  #           init.defaultBranch = "main";
  #           gpg.format = "ssh";
  #           branch.autosetuprebase = "always";
  #           color.ui = true;
  #           core.askPass = ""; # needs to be empty to use terminal for ask pass
  #           core.editor = "code --wait";
  #           credential.helper = "store"; # want to make this more secure
  #           github.user = "zerodeth";
  #           push.default = "tracking";
  #       };

  #       signing = {
  #           # key = "~/.ssh/id_ed25519";
  #           # signByDefault = builtins.stringLength "~/.ssh/id_ed25519" > 0;
  #           key = "FDA619F16BBFA377";
  #           signByDefault = true;
  #       };

  #       lfs.enable = true;
  #       ignores = [ "*~" "*.swp" "*.history" "*.terraform/" "*.nix-node" "*.direnv" "result" ];
  # };

}
