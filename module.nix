# To-do: make this work.
# { ... }: {
#   config = {
#     # To-do: make it unnecessary to copy secret and chat id to tsoping's home directory manually.
#    
#     users.users.tsoping = {
#       description = "Tsoping service user";
#       isSystemUser = true;
#       group = "tsoping";
#       createHome = true;
#       home = "/home/tsoping";
#     };
#   
#     users.groups.tsoping = {};
#   
#     systemd.services.tsoping = {
#       after = [ "network-online.target" ];
#       wants = [ "network-online.target" ];
#       wantedBy = [ "multi-user.target" ];
#       unitConfig = {
#         User = "tsoping";
#         Group = "tsoping";
#       };
#       script = ''
#         cd /home/tsoping
#         ${tsoping.packages.${pkgs.system}.tsoping}/bin/tsoping run
#       '';
#       serviceConfig.Type = "oneshot";
#       startAt = "hourly";
#       restartIfChanged = false;
#     };
#   };
# }
