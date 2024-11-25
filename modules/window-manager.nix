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

      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";

        startup = [
          {
            command = "mako";
          }
          {
            command = "makoctl reload";
            always = true;
          }
          {
            command = "systemctl --user restart kanshi";
            always = true;
          }
          {
            # This ensures all user units started after the command (not those already running) set the variables
            command = "systemctl --user import-environment";
          }
        ];

        keybindings = mkOptionDefault {
          "${modifier}+Ctrl+l" = "exec swaylock";
          "${modifier}+Shift+s" = "exec flameshot gui";
          "${modifier}+Tab" = "workspace back_and_forth";
          "${modifier}+d" = "exec fuzzel";
          "${modifier}+x" = "splitv";
          "${modifier}+v" = "splith";
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
            bg = "#000000 solid_color";
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
          outer = 5;
        };

        colors = {
          background = config.colors.bg;
          focused = {
            background = config.colors.cyan;
            border = config.colors.cyan;
            childBorder = config.colors.cyan;
            indicator = config.colors.cyan;
            text = config.colors.bg;
          };
          focusedInactive = {
            background = config.colors.bg_light;
            border = config.colors.bg_light;
            childBorder = config.colors.bg_light;
            indicator = config.colors.bg_light;
            text = config.colors.text_dark;
          };
          unfocused = {
            background = config.colors.bg_light;
            border = config.colors.bg_light;
            childBorder = config.colors.bg_light;
            indicator = config.colors.bg_light;
            text = config.colors.text_dark;
          };
          urgent = {
            background = config.colors.error_bg;
            border = config.colors.error_bg;
            childBorder = config.colors.error_bg;
            indicator = config.colors.error_bg;
            text = config.colors.error_text;
          };
        };

        bars = [
          {
            position = "top";
            trayOutput = null;
            colors = {
              background = config.colors.bg;
              statusline = config.colors.pink;
              focusedWorkspace = {
                background = config.colors.cyan;
                border = config.colors.cyan;
                text = config.colors.bg;
              };
              inactiveWorkspace = {
                background = config.colors.bg_light;
                border = config.colors.bg_light;
                text = config.colors.text_dark;
              };
              urgentWorkspace = {
                background = config.colors.error_bg;
                border = config.colors.error_bg;
                text = config.colors.error_text;
              };
            };
          }
        ];
      };
    };

    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "alacritty -e";
        };
      };
    };

    programs.swaylock = {
      enable = true;
      settings = {
        color = "000000";
      };
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

    services.mako = {
      enable = true;
      anchor = "top-center";
      margin = "30,20,10";
      layer = "overlay";
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

    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk = {
        enable = true;
      };
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
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
