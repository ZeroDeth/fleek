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
    # NIXPKGS_ALLOW_UNFREE= "1";
    # NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM= "1";
    # SSH_AUTH_SOCK = "~/.1password/agent.sock";
    # OP_BIOMETRIC_UNLOCK_ENABLED = "true";
  };

  # home.file.".gnupg/gpg-agent.conf".source = ./gpg-agent.conf;
  # home.file.".config/fish/kubectl_aliases.fish".source = ./kubectl_aliases.fish; #TODO: https://github.com/lccambiaghi/nixpkgs/blob/main/home/programs/shells/aliases.nix

  # home.file.".config/aliases/kubectl_aliases".source = ./kubectl_aliases;

    home.file = {
    ".config/aliases/kubectl_aliases" = {
        source = ./kubectl_aliases;
    };
    ".tmux.conf" = {
        text = ''
        set-window-option -g mode-keys vi
        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ',screen-256color:Tc'
        '';
    };
    ".tool-versions" = {
        text = ''
        # pre-commit 2.17.0
        # nodejs 17.9.0
        # flutter 2.10.5-stable
        # sbt 1.5.2
        # python 3.10.4
        # poetry 1.6.1
        # yarn 1.22.19
        # gradle 7.5.1
        # java openjdk-19.0.2
        # maven 3.9.1
        # talosctl 1.3.6
        # clusterctl 1.4.1

        # nodejs lts
        # ruby 3.1.0
        # python 3.10.1
        # direnv 2.32.2
        # golang 1.18.9
        # golang 1.19.12
        golang 1.20.6
        # neovim nightly
        terraform 1.4.2
        # terraform-validator 3.1.3
        # terraform-docs 0.16.0
        '';
      };
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs = {
    bash = {
      enable = true;
      enableCompletion = false;
      shellOptions = [];
      historyControl = [ "ignoredups" "ignorespace" ];
      shellAliases = config.programs.fish.shellAliases;
      initExtra = builtins.readFile ./bashrc;
      bashrcExtra = ''
          export GPG_TTY="$(tty)"
          export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
          # . ${pkgs.asdf-vm}/share/bash-completion/completions/asdf.bash
          # . ${pkgs.asdf-vm}/share/asdf-vm/asdf.sh

          # Aliases
          source ~/.config/aliases/kubectl_aliases

          # 1Password
          source ~/.config/op/plugins.sh
      '';

      # shellAliases = {
      #   ga = "git add";
      #   gc = "git commit";
      #   gco = "git checkout";
      #   gcp = "git cherry-pick";
      #   gdiff = "git diff";
      #   gl = "git prettylog";
      #   gcount = "git shortlog -sn";
      #   glg = "git log --stat";
      #   gwch = "git whatchanged -p --abbrev-commit --pretty=medium";
      #   gp = "git push";
      #   gs = "git status";
      #   gt = "git tag";
      #   gfa = "git fetch --all";
      #   gpa = "git pull --all";
      # };
    };

    zsh = {
      shellAliases = config.programs.fish.shellAliases;
      enableAutosuggestions = true;
#      enableCompletion = true; #TODO: already enabled by default
      syntaxHighlighting = {
        enable = true;
      };
      defaultKeymap = "emacs";
      history = {
        size = 10000;
        save = 10000;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
      };
      historySubstringSearch.enable = true;

      plugins = [
        {
          name = "fast-syntax-highlighting";
          src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
        }
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.5.0";
            sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
          };
        }
      ];

      completionInit =
        ''
          autoload -Uz compinit && compinit
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
        ''
      ;

#      envExtra = ''
#        export PATH=$PATH:/opt/homebrew/bin
#      '';

      # interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      #   (builtins.readFile ./zshrc)
      # ]);

      # dirHashes = {
      #     nixpkgs = "/etc/nix/path/nixpkgs";
      #     home-manager = "/etc/nix/path/home-manager";
      #     share = "/mnt/persist/share";
      #     flake = "/mnt/persist/zerodeth/flake";

      # loginExtra = ''
      #     cd ~/workspace
      # '';

      # initExtraFirst = ''
          # Set PATH, MANPATH, etc., for Homebrew.
          # eval "$(/opt/homebrew/bin/brew shellenv)"
      # '';
      initExtra = ''

          # Nix
          if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
            . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
          fi
          # End Nix

          # Configure PNPM
          # export PNPM_HOME="/Users/zerodeth/Library/pnpm"
          # export PATH="$PNPM_HOME:$PATH"

          # Brew
          eval "$(/opt/homebrew/bin/brew shellenv)"

          # 1Password
          #export SSH_AUTH_SOCK=~/.1password/agent.sock
          #source ~/.config/op/plugins.sh

          # Configure ASDF
          . $(brew --prefix asdf)/libexec/asdf.sh

          # Colima and Docker https://stackoverflow.com/a/72560928/6611169
          export DOCKER_HOST="unix://$HOME/.colima/docker.sock"

          # Aliases
          source ~/.config/aliases/kubectl_aliases

          # Warp - For zsh subshells
          printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh"}}\x9c'

      '';
    };

    fish = {
      enable = true;
      package = pkgs.fish;
      shellInit = ''
          # Set syntax highlighting colours; var names defined here:
          # http://fishshell.com/docs/current/index.html#variables-color
          set fish_color_normal normal
          set fish_color_command white
          set fish_color_quote brgreen
          set fish_color_redirection brblue
          set fish_color_end white
          set fish_color_error -o brred
          set fish_color_param brpurple
          set fish_color_comment --italics brblack
          set fish_color_match cyan
          set fish_color_search_match --background=brblack
          set fish_color_operator cyan
          set fish_color_escape white
          set fish_color_autosuggestion brblack
    '';

      interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      #   "source ${sources.theme-bobthefish}/functions/fish_prompt.fish"
      #   "source ${sources.theme-bobthefish}/functions/fish_right_prompt.fish"
      #   "source ${sources.theme-bobthefish}/functions/fish_title.fish"
          (builtins.readFile ./config.fish)
          "set -g SHELL ${pkgs.fish}/bin/fish"

          # 1Password
          # "set -gx SSH_AUTH_SOCK ~/.1password/agent.sock"

          # Activate the iTerm 2 shell integration
          # "iterm2_shell_integration"
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

        bnix = "nix-shell --run bash";
        znix = "nix-shell --run zsh";
        fnix = "nix-shell --run fish";

        # oplogin = "op signin --account my.1password.com sherif@abdalla.uk";

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

      # Abbreviate commonly used functions
      # An abbreviation will expand after <space> or <Enter> is hit
      shellAbbrs = {
          # oplogin = "op signin my.1password.com sherif@abdalla.uk";

          # Administer like a sir
          please = "sudo";

          # Personal/Work spacess
          ws = "cd ~/workspace";
          wsp = "cd ~/workspace/personal";
          wsb = "cd ~/workspace/business";
          nixos-config = "cd ~/workspace/nixos-config";
      };

      plugins = [
          # {
          #     name = "iterm2-shell-integration";
          #     src = ./iterm2_shell_integration.fish;
          # }
          {
              name = "fish-fzf";
              src = pkgs.fetchFromGitHub {
              owner = "jethrokuan";
              repo = "fzf";
              rev = "479fa67d7439b23095e01b64987ae79a91a4e283";
              sha256 = "0k6l21j192hrhy95092dm8029p52aakvzis7jiw48wnbckyidi6v";
              };
          }
          # {
          #     name = "fzf";
          #     src = pkgs.fetchFromGitHub {
          #     owner = "PatrickF1";
          #     repo = "fzf.fish";
          #     rev = "6d8e962f3ed84e42583cec1ec4861d4f0e6c4eb3";
          #     sha256 = "sha256-0rnd8oJzLw8x/U7OLqoOMQpK81gRc7DTxZRSHxN9YlM";
          #     };
          # }
          # Need this when using Fish as a default macOS shell in order to pick
          # up ~/.nix-profile/bin
          # {
          #     name = "nix-env";
          #     src = pkgs.fetchFromGitHub {
          #     owner = "lilyball";
          #     repo = "nix-env.fish";
          #     rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
          #     sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
          #     };
          # }
          {
              name = "fish-abbreviation-tips";
              src = pkgs.fetchFromGitHub {
              owner = "gazorby";
              repo = "fish-abbreviation-tips";
              rev = "8ed76a62bb044ba4ad8e3e6832640178880df485";
              sha256 = "05b5qp7yly7mwsqykjlb79gl24bs6mbqzaj5b3xfn3v2b7apqnqp";
              };
          }
      ];
    };

    starship = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
      enableFishIntegration = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        add_newline = true;

        git_branch = {
          disabled = false;
          symbol = " ";
          style = "bold purple";
          always_show_remote = true;
          only_attached = false;
        };

        time = {
          disabled = true;
          use_12hr = true;
          time_format = "'%T'";
          utc_time_offset = "'local'";
        };

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        directory = {
          style = "blue";
          truncate_to_repo = false;
          truncation_length = 8;
        };

        hostname = {
          disabled = false;
          style = "bold green";
          ssh_only = true;
          ssh_symbol = "🌏 ";
        };

        package.disabled = false;
        golang.disabled = false;
        python.disabled = false;
        ruby.disabled = false;
        kubernetes.disabled = false;
        aws.disabled = false;
        gcloud = {
          disabled = false;
          symbol = "☁️ ";
          # format = "'[$symbol$active]($style)'";
          format = "on [$symbol$account(@$domain)(\($project\))]($style) ";
          style = "bold yellow";
          region_aliases = {
            europe-west1 = "ew1";
            europe-west2 = "ew2";
          };
          project_aliases = {
            management = "mgmt";
            production-core = "prd-core";
            staging-core = "stg-core";
            testing-core = "tst-core";
            production-earth = "prd-earth";
            staging-earth = "stg-earth";
            testing-earth = "testnet-earth";
          };
        };
      };
    };

    dircolors = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = true;
      enableFishIntegration = true;
      extraConfig = ''
        TERM alacritty
    '';
      settings = {
          ".iso" = "01;31"; # .iso files bold red like .zip and other archives
          ".gpg" = "01;33"; # .gpg files bold yellow
          # Images to non-bold magenta instead of bold magenta like videos
          ".bmp"   = "00;35";
          ".gif"   = "00;35";
          ".jpeg"  = "00;35";
          ".jpg"   = "00;35";
          ".mjpeg" = "00;35";
          ".mjpg"  = "00;35";
          ".mng"   = "00;35";
          ".pbm"   = "00;35";
          ".pcx"   = "00;35";
          ".pgm"   = "00;35";
          ".png"   = "00;35";
          ".ppm"   = "00;35";
          ".svg"   = "00;35";
          ".svgz"  = "00;35";
          ".tga"   = "00;35";
          ".tif"   = "00;35";
          ".tiff"  = "00;35";
          ".webp"  = "00;35";
          ".xbm"   = "00;35";
          ".xpm"   = "00;35";
      };
    };

    # For information about available direnv options,
    # please see: https://direnv.net/man/direnv.toml.1.html
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      # enableFishIntegration = true; # TODO: it's set multiple times
      nix-direnv = {
        enable = true;
      };
      config = {
        global.load_dotenv = true;
        global.strict_env = true;
        global.warn_timeout = "400ms";
      };
    };

    zoxide = {
        # enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
    };

    gh = {
      enable = true;         #TODO: Moved and working well under homebrew
      gitCredentialHelper = {
        enable = true;
      };
      settings = {
        git_protocol = "ssh";
        # prompt = "enabled";
        # aliases = {
        #   co = "pr checkout";
        #   pv = "pr view";
        # };
      };
    };

    git = {
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
          core = {
              # If git uses `ssh` from Nix the macOS-specific configuration in
              # `~/.ssh/config` won't be seen as valid
              # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
              # sshCommand = "/usr/bin/ssh";
              askPass = ""; # needs to be empty to use terminal for ask pass
              editor = "code --wait";
          };
          color = {
              ui = true;
          };
          diff = {
            colorMoved = "default";
          };
          merge = {
            conflictstyle = "zdiff3";
          };
          feature.manyFiles = true;
          advice.detachedHead = false;
          init.defaultBranch = "main";
          commit.gpgSign = true;
          push = {
              autoSetupRemote = true;
              default = "tracking";
          };

          # TODO: improve this hack (if possible)
          gpg = lib.mkForce { program = lib.mkForce "${pkgs.gnupg}/bin/gpg2"; };
          tag = {
              forceSignAnnotated = true;
              gpgSign = true;
          };
          branch.autosetuprebase = "always";
          credential = {
              helper = "store"; # want to make this more secure
              credentialStore = "gpg";
          };
          github.user = "zerodeth";
          # Clone git repos with URLs like "gh:zerodeth/dotfiles"
          # url."git@github.com:" = {
          #   insteadOf = "gh:";
          #   pushInsteadOf = "gh:";
          # };
      };

      signing = lib.mkForce {
        # key = "~/.ssh/id_ed25519";
        # signByDefault = builtins.stringLength "~/.ssh/id_ed25519" > 0;
        key = "FDA619F16BBFA377";
        signByDefault = true;
        gpgPath = "${pkgs.gnupg}/bin/gpg2";
      };

      diff-so-fancy.enable = false;

      lfs.enable = true;
      ignores = [ "*~" "*.swp" "*.history" ".DS_Store" "*.terraform/" "*.nix-node" "*.direnv" "result" "*.venv" "*.direnv" "*.idea" ];
    };

    ssh = {
      enable = true;
      forwardAgent = false;
      # AddKeysToAgent = true;
      # useKeychain = true;
      # identityFile = "~/.ssh/id_ed25519";
      # identitiesOnly = true;
      # logLevel = "INFO";
      # serverAliveInterval = "60";
      # serverAliveCountMax = "20";
      # Compression = true;
      # AddressFamily = "inet";
      # protocol = "2";
      # preferredAuthentications = "publickey";
      # extraConfig = {
      #   RequestTTY = "no";
      # };
      extraConfig = builtins.readFile ./config;

      # ProxyCommand = "/usr/local/bin/krssh %h %p";
      # hashKnownHosts = true;
      # controlMaster = "auto";
      # controlPath = "~/.ssh/master-%r@%h:%p";

      # matchBlocks = {
      #   "foo-host" = {
      #     hostname = "host.foo.tld";
      #     user = "root";
      #     port = 22;
      #     identityFile = "~/.ssh/id_ed25519";
      #   };
      #   "bastion-proxy" = {
      #     hostname = "bastion.example.net";
      #     user = "ec2-user";
      #     port = 443;
      #     identityFile = "~/.ssh/id_ed25519";
      #     identitiesOnly = true;
      #     dynamicForwards = [ { port = 8080; } ];
      #     extraOptions = {
      #       RequestTTY = "no";
      #     };
      #   };
      #   work = {
      #     host = (lib.concatStringsSep " " workHosts);
      #     user = workUser;
      #     proxyJump = "bastion-proxy";
      #     certificateFile = "~/.ssh/id_ecdsa-cert.pub";
      #     identitiesOnly = true;
      #   };
      # };
    };

    # alacritty = {
    #   enable = true;

      # settings = {
      #   env.TERM = "xterm-256color";

      #   key_bindings = [
      #     { key = "K"; mods = "Command"; chars = "ClearHistory"; }
      #     { key = "V"; mods = "Command"; action = "Paste"; }
      #     { key = "C"; mods = "Command"; action = "Copy"; }
      #     { key = "Key0"; mods = "Command"; action = "ResetFontSize"; }
      #     { key = "Equals"; mods = "Command"; action = "IncreaseFontSize"; }
      #     { key = "Subtract"; mods = "Command"; action = "DecreaseFontSize"; }
      #   ];
      # };
    # };

    # kitty = {
    #   enable = true;
    #   extraConfig = builtins.readFile ./kitty;
    # };

    topgrade = {
      enable = true;
      # extraConfig = builtins.readFile ./topgrade; #TODO: Add config file by chezmoi for now
    };

  };

  #---------------------------------------------------------------------
  # Services
  #---------------------------------------------------------------------

  # services = {
  #   nix-daemon = {
  #     enable = true;
  #   };

  #   tailscale = {
  #     enable = true;
  #     package = pkgs.tailscale;
  #   };
  # };

}
