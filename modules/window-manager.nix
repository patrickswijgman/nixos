{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

{
  home-manager.users.patrick = {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";

        startup = [
          {
            command = "systemctl --user restart kanshi";
            always = true;
          }
        ];

        keybindings = mkOptionDefault {
          "Mod4+Ctrl+l" = "exec swaylock";
          "Mod4+Shift+s" = "exec flameshot gui";
          "Mod4+Tab" = "workspace back_and_forth";
          "Mod4+d" = "exec fuzzel";
          "Mod4+x" = "splitv";
          "Mod4+v" = "splith";
          "XF86AudioMute" = "exec pamixer -t";
          "XF86AudioRaiseVolume" = "exec pamixer -i 5";
          "XF86AudioLowerVolume" = "exec pamixer -d 5";
          "XF86AudioPlay" = "exec playerctl play-pause";
          "XF86AudioNext" = "exec playerctl next";
          "XF86AudioPrev" = "exec playerctl previous";
          "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
          "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
        };

        input = {
          "type:pointer" = {
            accel_profile = "flat";
            pointer_accel = "-0.4";
            scroll_factor = "1";
          };
        };

        output = {
          "*" = {
            bg = "#11111b solid_color";
          };
        };

        window = {
          titlebar = false;
        };

        floating = {
          titlebar = false;
        };

        gaps = {
          inner = 10;
          outer = 0;
        };

        colors = {
          background = "$base";
          focused = {
            border = "$lavender";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            childBorder = "$lavender";
          };
          focusedInactive = {
            border = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            childBorder = "$overlay0";
          };
          unfocused = {
            border = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            childBorder = "$overlay0";
          };
          urgent = {
            border = "$peach";
            background = "$base";
            text = "$peach";
            indicator = "$overlay0";
            childBorder = "$peach";
          };
        };

        bars = [
          { command = "waybar"; }
        ];

      };
    };

    # https://github.com/Alexays/Waybar/wiki
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";

          modules-left = [
            "sway/workspaces"
          ];

          modules-center = [
            "sway/window"
          ];

          modules-right = [
            "custom/music"
            "cpu"
            "memory"
            "disk"
            "network"
            "pulseaudio"
            "battery"
            "backlight"
            "clock"
            "custom/lock"
            "custom/power"
          ];

          "sway/workspaces" = {
            disable-scroll = true;
            format = " {icon}  {name} ";
            format-icons = {
              default = "";
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "8" = "";
              "9" = "";
              "10" = "";
            };
          };

          "sway/window" = {
            max-length = 50;
          };

          "custom/music" = {
            tooltip = false;
            escape = true;
            format = "  {}";
            exec = "playerctl metadata --format='{{ title }}'";
            on-click = "playerctl play-pause";
            max-length = 50;
            interval = 5;
          };

          "cpu" = {
            format = "  {usage}%";
          };

          "memory" = {
            format = "  {percentage}%";
            tooltip-format = "Used: {used:0.1f} / {total:0.1f} GiB";
          };

          "disk" = {
            format = "  {percentage_used}%";
            tooltip-format = "Used: {specific_used:0.2f} / {specific_total:0.2f} GiB";
            unit = "GB";
          };

          "network" = {
            format = "";
            format-wifi = "  {signalStrength}%";
            format-ethernet = "";
            format-disconnected = "";
            tooltip-format-wifi = "SSID: {essid} | IP: {ipaddr}";
            tooltip-format-ethernet = "IP: {ipaddr}";
            tooltip-format-disconnected = "Disconnected";
          };

          "clock" = {
            timezone = "Europe/Amsterdam";
            format = "  {:%H:%M}";
            tooltip-format = "{:%A %d %B %Y}";
          };

          "backlight" = {
            tooltip = false;
            device = "intel_backlight";
            format = "{icon}  {percent}%";
            format-icons = [
              ""
              ""
              ""
            ];
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}  {capacity}%";
            format-charging = "";
            format-plugged = "";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "pulseaudio" = {
            scroll-step = 5;
            format = "{icon}  {volume}%";
            format-bluetooth = " {icon}  {volume}%";
            format-muted = "";
            format-icons = {
              headphone = "";
              headset = "";
              hands-free = "";
              default = [
                ""
                ""
              ];
            };
          };

          "custom/lock" = {
            tooltip = false;
            on-click = "swaylock";
            format = "";
          };

          "custom/power" = {
            tooltip = false;
            on-click = "poweroff";
            format = "";
          };
        };
      };
      style = ''
        * {
          font-family: monospace;
          font-size: 12px;
          min-height: 0;
        }

        #waybar {
          background: @base;
          color: @text;
          margin: 5px 5px;
        }

        #workspaces {
          border-radius: 1rem;
          margin: 5px;
          background-color: @surface0;
          margin-left: 1rem;
        }

        #workspaces button {
          color: @lavender;
          border-radius: 1rem;
          padding: 0.4rem;
        }

        #workspaces button:hover {
          background-color: @surface1;
          border-radius: 1rem;
        }

        #workspaces button.focused {
          color: @sky;
          background-color: @surface1;
          border-radius: 1rem;
        }

        #workspaces button.urgent {
          color: @peach;
          background-color: @surface1;
          border-radius: 1rem;
        }

        #custom-music,
        #cpu,
        #memory,
        #disk,
        #network,
        #pulseaudio,
        #battery,
        #backlight,
        #clock,
        #custom-lock,
        #custom-power {
          background-color: @surface0;
          padding: 0.5rem 1rem;
          margin: 5px 0;
        }

        #custom-music {
          color: @mauve;
          border-radius: 1rem;
          margin-right: 1rem;
        }

        #cpu {
          color: @maroon;
          border-radius: 1rem 0px 0px 1rem;
        }

        #memory {
          color: @peach;
        }

        #disk {
          color: @yellow;
        }

        #network {
          color: @green;
        }

        #pulseaudio {
          color: @teal;
        }

        #battery {
          color: @sky;
        }

        #backlight {
          color: @sapphire;
        }

        #clock {
          color: @blue;
          border-radius: 0px 1rem 1rem 0px;
          margin-right: 1rem;
        }

        #custom-lock {
          border-radius: 1rem 0px 0px 1rem;
          color: @lavender;
        }

        #custom-power {
          margin-right: 1rem;
          border-radius: 0px 1rem 1rem 0px;
          color: @red;
        }
      '';
    };

    programs.fuzzel = {
      enable = true;
    };

    programs.swaylock = {
      enable = true;
    };

    services.swaync = {
      enable = true;
    };

    services.swayidle = {
      enable = true;
      systemdTarget = "sway-session.target";
      timeouts = [
        {
          timeout = 180;
          command = "swaylock";
        }
      ];
    };

    services.kanshi = {
      enable = true;
      settings = [
        # Desktop
        {
          profile.outputs = [
            {
              criteria = "Iiyama North America PL2760Q 1154192101586";
              mode = "2560x1440@143.856Hz";
            }
          ];
        }
        # Laptop
        {
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
            }
          ];
        }
        {
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "Iiyama North America PL2760Q 1154192101586";
            }
          ];
        }
        {
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            {
              criteria = "Dell Inc. DELL U2720Q 87RFX83";
              scale = 1.5;
            }
          ];
        }
      ];
    };

    services.flameshot = {
      enable = true;
      settings = {
        General = {
          disabledTrayIcon = true;
          showDesktopNotification = false;
          showSidePanelButton = false;
          showHelp = false;
        };
      };
    };

    home.packages = with pkgs; [
      xdg-utils
      wl-clipboard
      pamixer
      playerctl
      brightnessctl
    ];

    home.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "sway";
      NIXOS_OZONE_WL = "1";
    };
  };

  # Grant more (within certain boundaries) privileges to programs.
  security.polkit.enable = true;

  # Fix for swaylock to be able to detect a correct password.
  security.pam.services.swaylock = { };

  # Enable OpenGL for hardware acceleration.
  hardware.graphics.enable = true;

  # Enable database for GNOME settings.
  programs.dconf.enable = true;

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
}
