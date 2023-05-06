{ pkgs, misc, lib, config, ... }: {
  # FEEL FREE TO EDIT: This file is NOT managed by fleek.

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

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_GB.UTF-8";
    LC_CTYPE = "en_GB.UTF-8";
    LC_ALL = "en_GB.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    # MANPAGER = "${manpager}/bin/manpager";
    FLEEK_MANAGED= "1";
    # FLEEK_DEBUG= "1";
  };

  # home.file.".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];
    initExtra = builtins.readFile ./bashrc;
    bashrcExtra = ''
        export GPG_TTY="$(tty)"
        export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
        # . ${pkgs.asdf-vm}/share/bash-completion/completions/asdf.bash
        # . ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh
    '';

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gcount = "git shortlog -sn";
      glg = "git log --stat";
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
      gfa = "git fetch --all";
      gpa = "git pull --all";
    };
  };

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

  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
    #   "source ${sources.theme-bobthefish}/functions/fish_prompt.fish"
    #   "source ${sources.theme-bobthefish}/functions/fish_right_prompt.fish"
    #   "source ${sources.theme-bobthefish}/functions/fish_title.fish"
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    shellAliases = {
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gcp = "git cherry-pick";
      gdiff = "git diff";
      gl = "git prettylog";
      gcount = "git shortlog -sn";
      glg = "git log --stat";
      gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
      gp = "git push";
      gs = "git status";
      gt = "git tag";
      gfa = "git fetch --all";
      gpa = "git pull --all";

    #   ls = "exa";
    #   ll = "exa -l";
    #   la = "exa --long --all --group --header --group-directories-first --sort=type --icons";
    #   lla = "exa -la";
      lg = "exa --long --all --group --header --git";
    #   lt = "exa --long --all --group --header --tree --level ";

      rm = "trash-put";
      unrm = "trash-restore";
      rmcl = "trash-empty";
      rml = "trash-list";

      # ossw = "sudo nixos-rebuild switch --flake '/etc/nixos/#nixtst' --impure -v";
      # hmsw = "home-manager switch --flake ~/.config/nixpkgs/#$USER";
      # upa = "nix flake update ~/.config/nixpkgs -v && sudo nix flake update '/etc/nixos/' -v";
      # fusw = "upa && ossw && hmsw";
      # rusw = "ossw && hmsw";
      ucl = "nix-collect-garbage -d && nix-store --gc && nix-store --repair --verify --check-contents && nix-store --optimise -vvv";
      scl = "sudo nix-collect-garbage -d && sudo nix-store --gc && sudo nix-store --repair --verify --check-contents && sudo nix-store --optimise -vvv";
      acl = "ucl && scl";

    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };

  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # For information about available direnv options,
  # please see: https://direnv.net/man/direnv.toml.1.html
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    config = {
      global.load_dotenv = true;
      global.strict_env = true;
      global.warn_timeout = "400ms";
    };
  };

  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

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
      advice.detachedHead = false;
      init.defaultBranch = "main";
      commit.gpgSign = true;
      push.autoSetupRemote = true;

      # TODO: improve this hack (if possible)
      gpg = lib.mkForce { program = lib.mkForce "${pkgs.gnupg}/bin/gpg2"; };
      tag = {
        forceSignAnnotated = true;
        gpgSign = true;
      };
      branch.autosetuprebase = "always";
      color.ui = true;
      core.askPass = ""; # needs to be empty to use terminal for ask pass
      core.editor = "code --wait";
      credential.helper = "store"; # want to make this more secure
      credential.credentialStore = "gpg";
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

}
