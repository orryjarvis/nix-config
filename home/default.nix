{ ... }:

{
  
              home.stateVersion = "26.05";

              manual = {
                html.enable = false;
                json.enable = false;
                manpages.enable = false;
              };
              
              home.file.".ssh/known_hosts.d/github".source = ../ssh/github_known_hosts;
              home.file.".ssh/allowed_signers".source = ../ssh/allowed_signers;
              
              home.sessionVariables = {
                EDITOR = "hx";
                VISUAL = "hx";
              };
              
              programs.bash = {
                enable = true;  
              };
              
              programs.ssh = {
                enable = true;
                enableDefaultConfig = false;

                settings = {
                  "github.com" = {
                    HostName = "github.com";
                    User = "git";
                    IdentityFile = "~/.ssh/id_ed25519";
                    IdentitiesOnly = true;
          
                    UserKnownHostsFile = "~/.ssh/known_hosts.d/github";
                    StrictHostKeyChecking = "yes";
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
                  gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
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

              programs.helix = {
                enable = true;

                settings = {
                  editor = {
                    mouse = false;
                  };
                };
              };
}
