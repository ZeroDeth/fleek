{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
   home.shellAliases = {
    "apply-macOS-W.local" = "nix run --impure home-manager/master -- -b bak switch --flake .#zerodeth@macOS-W.local";
    
    "fleeks" = "cd ~/.local/share/fleek";
    
    "latest-fleek-version" = "nix run https://getfleek.dev/latest.tar.gz -- version";
    
    "pinentry-mac" = "~/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";
    
    "update-fleek" = "nix run https://getfleek.dev/latest.tar.gz -- update";
    };
}
