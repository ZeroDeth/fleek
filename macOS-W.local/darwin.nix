{ config, pkgs, home-manager, ... }: {

#   nixpkgs.overlays = import ../../lib/overlays.nix ++ [
#     (import ./vim.nix)
#   ];

  # nix = {
  #   buildMachines = [
  #     {
  #       hostName = "aarch64-darwin-builder";
  #       systems = [ "aarch64-darwin" "x86_64-darwin" ];
  #       maxJobs = 1;
  #       speedFactor = 2;
  #     }
  #     {
  #       hostName = "linux-builder";
  #       systems = [ "x86_64-linux" "aarch64-linux" ];
  #       maxJobs = 1;
  #       speedFactor = 2;
  #     }
  #   ];
  #   distributedBuilds = true;
  #   settings.trusted-users = [
  #     "@admin"
  #     "@wheel"
  #   ];
  #   settings.builders-use-substitutes = false;
  #   settings.experimental-features = [
  #     "nix-command"
  #     "flakes"
  #   ];
  #   settings.extra-platforms = [
  #     "x86_64-darwin"
  #     "aarch64-darwin"
  #   ];
  #   # package = nixpkgs-unstable.nix;
  # };

  security.pam.enableSudoTouchIdAuth = pkgs.stdenv.isDarwin;

  homebrew = {
    enable = pkgs.stdenv.isDarwin;
    onActivation.upgrade = false;
    brews = [
      # "pinentry-mac"
      # "jq"
      # "yq"
      "mas"
    ];
    casks  = [
      "1password"
    #   "alfred"
    #   "cleanshot"
      # "discord"
      "google-chrome"
    #   "imageoptim"
      # "istat-menus"
    #   "monodraw"
    #   "rectangle"
    #   "screenflow"
      # "slack"
    #   "spotify"
    ];
    masApps = {
      Xcode = 497799835;
      # We prefer to use Tailscale nix-darwin modules, so we comment this out
      # Tailscale = 1475387142;
      # WhatsAppWeb = 1147396723;
      # SlackDesktop = 803453959;
    };
  };

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.zerodeth = {
    home = "/Users/zerodeth";
    shell = pkgs.zsh;
  };

}
