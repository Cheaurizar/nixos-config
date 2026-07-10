{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "1h";
        controlMaster = "auto";
        controlPath = "~/.ssh/control-%r@%h:%p";
        controlPersist = "10m";
        forwardAgent = false;
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
      github = {
        host = "github.com";
        hostname = "ssh.github.com";
        user = "git";
        port = 443;
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
      codeberg = {
        host = "codeberg.org";
        hostname = "codeberg.org";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_codeberg";
        identitiesOnly = true;
      };
    };
  };
  services.ssh-agent.enable = true;
}
