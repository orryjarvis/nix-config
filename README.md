# TODO
- separate hosts
- further file/module separation
- productivity
  - task running
  - git hooks
  - linting / static analysis
  - dependency analysis?
  - shell config
    - readable colors
    - completions
    - context (git branch, etc)
  - codex
    - agent config
  - multiplexer

# New machine bootstrapping
Note: Step 3 is unnecessary if using a custom tarball output from this repo for step 1
1. Install NixOS.wsl from latest release
2. get flake files onto the machine
3. build and switch to flake -- special sequence to create new user
4. ssh keys (instructions below)

## Initial flake + new user bootstrap (non custom tarball)
In NixOS:
1. sudo nixos-rebuild boot --flake .#nixos
From powershell:
2. wsl -t NixOS
3. wsl -d NixOS --user root exit
4. wsl -t NixOS

## Build custom tarball
```
sudo nix run \
  --print-build-logs \
  --extra-experimental-features "nix-command flakes" \
  .#nixosConfigurations.nixos.config.system.build.tarballBuilder
```

## Developing
- `nix flake check`
- `nix flake update`
- `sudo nixos-rebuild switch --flake .#nixos`
- `exec bash` if shell config is supposed to change between generations

## formatting
- `nix fmt *.nix`

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
