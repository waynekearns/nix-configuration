{ config, pkgs, ... }:

{
  imports =
    [
      ./discord
      ./dunst
      ./emacs
      ./nvim
      ./rofi
      ./urxvt
      ./zathura
    ];

  services.picom = {
    enable = true;
    inactiveOpacity = "0.90";
    activeOpacity = "1.00";
    blur = true;
    experimentalBackends = true;
    opacityRule = [
      "100:class_g  *?= 'urxvt'"
      "90:class_g   *?= 'Emacs'"
      "80:class_g   *?= 'discord'"
      "80:class_g   *?= 'Rofi'"
    ];
    extraOptions = ''
      blur-method = "dual_kawase";
      blur-strength = 8;

      corner-radius = 45;
      round-borders = 1;
      rounded-corners-exclude = [
        "name *?= 'tint2'",
      ];
    '';
    fade = true;
    fadeDelta = 3;
    shadow = false;
    shadowExclude = [
    ];
    vSync = true;
    package = pkgs.picom.overrideAttrs (
      o: {
        src = pkgs.fetchFromGitHub {
          owner = "Arian8j2";
          repo = "picom-jonaburg-fix";
          rev = "31d25da22b44f37cbb9be49fe5c239ef8d00df12";
          sha256 = "1z4bKDoNgmG40y2DKTSSh1NCafrE1rkHkCB3ob8ibm4=";
        };
      }
    );
  };

  home.file = {
    ".config/xmobar/xmobarrc0".text = builtins.readFile ./xmobar/xmobarrc0;
    ".config/xmobar/xmobarrc1".text = builtins.readFile ./xmobar/xmobarrc1;
    ".config/xmobar/xmobarrc2".text = builtins.readFile ./xmobar/xmobarrc2;
    ".config/xmobar/xmobarrc3".text = builtins.readFile ./xmobar/xmobarrc3;
    ".icons/icons" = {
      recursive = true;
      source = ./icons;
    };
  };

  home.packages = with pkgs; [
    orchis-theme
    #tela-icon-theme
    #gruvbox-dark-gtk
    zafiro-icons
    libsForQt5.qtstyleplugins
    #gsettings-desktop-schemas
    #gnome.gnome-themes-extra
  ];

  dconf.enable = true;
  gtk = {
    enable = true;

    font = {
      package = null;
      name = "mplus Nerd Font 10";
    };

    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-green-dark";
    };

    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons";
    };

    gtk3.extraConfig = {
      gtk-icon-theme-name = "Zafiro-icons";
      gtk-theme-name = "Orchis-green-dark";
      gtk-application-prefer-dark-theme = 1;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "gtk2";
  };
}