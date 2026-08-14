# TODO
- build custom WSL tarball
- file/module separation
- productivity
  - modal editor
  - shell config
    - completions
    - context (git branch, etc)
  - codex
  - multiplexer

# New machine bootstrapping
Note: Steps 1 and 3 would be improved if I built a custom tarball
1. Install NixOS.wsl from latest release
2. get flake files onto the machine
3. build and switch to flake -- special sequence to create new user
4. ssh keys

## Initial flake + new user bootstrap
In NixOS:
1. sudo nixos-rebuild boot --flake .#nixos
From powershell:
2. wsl -t NixOS
3. wsl -d NixOS --user root exit
4. wsl -t NixOS

## Developing
- `nix flake check`
- `nix flake update`
- `sudo nixos-rebuild switch --flake .#nixos`

## ssh keys
Note, might have to relogin with some more parameters to get ssh admin 
control
```
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519

gh auth login

gh ssh-key add ~/.ssh/id_ed25519.pub \
  --type authentication \
  --title "$(hostname)"

gh ssh-key add ~/.ssh/id_ed25519.pub \
  --type signing \
  --title "$(hostname) signing"

#Add key to ssh/allowed_signers and commit
#So other machines can validate this machines commit
```
