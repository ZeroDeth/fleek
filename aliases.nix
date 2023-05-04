{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.

   home.shellAliases = {
    fleeks = "cd ~/.local/share/fleek";

    pinentry-mac = "~/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";

    catp = "bat -P";  # bat --plain for unformatted cat
    cat = "bat";      # replace cat with bat

    cz = "chezmoi";
    czg = "chezmoi git";

    db = "distrobox";

    ls = "exa";
    ll = "exa -l";
    # la = "exa --long --all --group --header --group-directories-first --sort=type --icons";
    lla = "exa -la";
    lg = "exa --long --all --group --header --git";
    # lt = "exa --long --all --group --header --tree --level";

    tf = "terraform";
  };

}
