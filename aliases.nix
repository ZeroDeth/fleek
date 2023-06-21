{ pkgs, misc, ... }: {
  # DO NOT EDIT: This file is managed by fleek. Manual changes will be overwritten.
   home.shellAliases = {
    "apply-macOS-W.local" = "nix run --impure home-manager/master -- -b bak switch --flake .#zerodeth@macOS-W.local";
    
    "fleeks" = "cd ~/.local/share/fleek";
    
    "pinentry-mac" = "~/.nix-profile/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac";
    };
}
