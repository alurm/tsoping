self: { config, lib, pkgs, ... }: let
  cfg = config.services.tsoping;
in {
  imports = [];

  options = {
    services.tsoping = let inherit (lib) mkOption types; in {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Enable Tsoping, a service to send a link to a Telegram chat when Tsoding uploads a new video.
        '';
      };
      chat-id-file = mkOption {
        type = types.path;
      };
      telegram-token-file = mkOption {
        type = types.path;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.tsoping = {
      description = "Tsoping service user";
      isSystemUser = true;
      group = "tsoping";
      createHome = true;
      home = "/home/tsoping";
    };
  
    users.groups.tsoping = {};
  
    systemd.services.tsoping = {
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      script = ''
        cd /home/tsoping
        \
          TSOPING_CHAT_ID_FILE="${cfg.chat-id-file}" \
          TSOPING_TELEGRAM_TOKEN_FILE="${cfg.telegram-token-file}" \
          exec \
          ${self.packages.${pkgs.system}.tsoping}/bin/tsoping run \
        ;
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "tsoping";
        Group = "tsoping";
      };
      startAt = "hourly";
      restartIfChanged = false;
    };
  };
}
