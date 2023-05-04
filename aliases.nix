{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
   home.shellAliases = {
    fleeks = "cd ~/.local/share/fleek";

    pinentry-mac = "~/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";

    # bat --plain for unformatted cat
    catp = "bat -P";

    # replace cat with bat
    cat = "bat";

    ls = "exa";
    ll = "exa -l";
    # la = "exa --long --all --group --header --group-directories-first --sort=type --icons";
    lla = "exa -la";
    lg = "exa --long --all --group --header --git";
    # lt = "exa --long --all --group --header --tree --level";
  };
}
