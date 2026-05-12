{ ... }:
{
  systemd.user.services.tri-downloads = {
    Unit.Description = "Trie les fichiers du dossier Downloads";
    Service = {
      Type = "oneshot";
      ExecStart = "/etc/profiles/per-user/%u/bin/script_tri_downloads";
    };
  };

  systemd.user.timers.tri-downloads = {
    Unit.Description = "Lance le tri des Downloads periodiquement";
    Install.WantedBy = [ "timers.target" ];
    Timer = {
      OnCalendar = "*-*~01 23:00:00";
      Persistent = true;
    };
  };
}
