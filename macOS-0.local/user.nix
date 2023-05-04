{ pkgs, misc, lib, config, ... }: {
  # FEEL FREE TO EDIT: This file is NOT managed by fleek.

    # home.username = "zerodeth";
    # home.homeDirectory = "/Users/zerodeth";

    programs.gh.enable = true;
    programs.gh.enableGitCredentialHelper = true;
    programs.gh.settings.git_protocol = "ssh";

    programs.git = {
        enable = true;
        aliases = {
            pushall = "!git remote | xargs -L1 git push --all";
            graph = "log --decorate --oneline --graph";
            add-nowhitespace = "!git diff -U0 -w --no-color | git apply --cached --ignore-whitespace --unidiff-zero -";
            prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";

        };
        userName = "Sherif Abdalla";
        userEmail = "sherif@abdalla.uk";
        extraConfig = {
            feature.manyFiles = true;
            init.defaultBranch = "main";
            # gpg.format = "ssh";
            # TODO: improve this hack (if possible)
            gpg = lib.mkForce { program = lib.mkForce "${pkgs.gnupg}/bin/gpg2"; };
            branch.autosetuprebase = "always";
            color.ui = true;
            core.askPass = ""; # needs to be empty to use terminal for ask pass
            core.editor = "code --wait";
            credential.helper = "store"; # want to make this more secure
            github.user = "zerodeth";
            push.default = "tracking";
        };

        signing = lib.mkForce {
            # key = "~/.ssh/id_ed25519";
            # signByDefault = builtins.stringLength "~/.ssh/id_ed25519" > 0;
            key = "FDA619F16BBFA377";
            signByDefault = true;
            gpgPath = "${pkgs.gnupg}/bin/gpg2";
        };

        lfs.enable = true;
        ignores = [ "*~" "*.swp" "*.history" "*.terraform/" "*.nix-node" "*.direnv" "result" ];
  };

  home.sessionVariables = {
    LANG = "en_GB.UTF-8";
    LC_CTYPE = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    # MANPAGER = "${manpager}/bin/manpager";
    FLEEK_MANAGED= "1";
  };

  home.file.".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;

  programs.zsh = {
    enableAutosuggestions = true;
    completionInit =
      ''
        autoload -Uz compinit && compinit
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      ''
    ;

    enableSyntaxHighlighting = true;
  };

  # nix = {
  #   # use unstable nix so we can access flakes
  #   package = pkgs.nixUnstable;
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #     keep-outputs = true
  #     keep-derivations = true
  #   '';

  #   # public binary cache that I use for all my derivations. You can keep
  #   # this, use your own, or toss it. Its typically safe to use a binary cache
  #   # since the data inside is checksummed.
  #   settings = {
  #     substituters = ["https://mitchellh-nixos-config.cachix.org"];
  #     trusted-public-keys = ["mitchellh-nixos-config.cachix.org-1:bjEbXJyLrL1HZZHBbO4QALnI5faYZppzkU4D2s0G8RQ="];
  #   };
  # };

}
