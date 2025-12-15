{
  "org/gnome/desktop/interface" = {
    gtk-theme = "Adwaita";
    color-scheme = "prefer-dark";
    accent-color = "blue";
  };
  # "org/gnome/shell" = {
  #   disable-user-extensions = true;
  # };
  "org/gnome/desktop/peripherals/mouse" = {
    accel-profile = "flat";
  };
  # stfu stupid bell!!!
  "org/gnome/desktop/sound" = {
    event-sounds = false;
  };
  "org/gnome/mutter" = {
    dynamic-workspaces = false;
  };
  "org/gnome/shell/keybindings" = {
    switch-to-application-1 = [ ];
    switch-to-application-2 = [ ];
    switch-to-application-3 = [ ];
    switch-to-application-4 = [ ];
  };
  "org/gnome/desktop/wm/keybindings" = {
    close = [ "<Shift><Super>q" ];
    toggle-fullscreen = [ "<Super>f" ];
    switch-to-workspace-1 = [ "<Super>1" ];
    switch-to-workspace-2 = [ "<Super>2" ];
    switch-to-workspace-3 = [ "<Super>3" ];
    switch-to-workspace-4 = [ "<Super>4" ];
    move-to-workspace-1 = [ "<Shift><Super>1" ];
    move-to-workspace-2 = [ "<Shift><Super>2" ];
    move-to-workspace-3 = [ "<Shift><Super>3" ];
    move-to-workspace-4 = [ "<Shift><Super>4" ];
    switch-applications = [ ];
    switch-applications-backward = [ ];
    switch-windows = [ "<Alt>Tab" ];
    switch-windows-backward = [ "<Shift><Alt>Tab" ];

  };
  "org/gnome/settings-daemon/plugins/media-keys" = {
    screensaver = [ "<Super>i" ];
    custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    ];
  };
  "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
    binding = "<Super>Return";
    command = "foot";
    name = "open-terminal";
  };
}
