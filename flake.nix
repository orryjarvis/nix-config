{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
            system.stateVersion = "26.05";
            wsl.enable = true;
 	    wsl.defaultUser = "orry";

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.orry = {
              home.stateVersion = "26.05";
              
              programs.ssh = {
                enable = true;
                enableDefaultConfig = false;

                settings = {
                  "github.com" = {
                    HostName = "github.com";
                    User = "git";
                    IdentityFile = "~/.ssh/id_ed25519";
                    IdentitiesOnly = true;
                  };
                };
              };

              programs.git = {
                enable = true;

                signing = {
                  format = "ssh";
                  key = "~/.ssh/id_ed25519.pub";
                  signByDefault = true;
                };

                settings = {
                  user.name = "Orry Jarvis";
                  user.email = "orryjarvis@gmail.com";
                  pull.rebase = true;
                  fetch.prune = true;
                  push.autoSetupRemote = true;                  
                  init.defaultBranch = "main";
	        };
              };

              programs.gh = {
                enable = true;

                settings = {
                  git_protocol = "ssh";
                };
              };
            };
          }
        ];
      };
    };
  };
}
