{
  config,
  pkgs,
  # nixgl,
  ...
}:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  # nixGL.packages = nixgl.packages;

  home.packages = with pkgs; [
    # firefox
    # mupdf
    # (config.lib.nixGL.wrap wezterm)

    # dev tools
    git-credential-manager
    tmux
    fzf
    postgresql
    # yazi

    # lsp and formatters
    nixd
    nixfmt-rfc-style
    lua-language-server
    stylua
    bash-language-server
    yaml-language-server
    marksman
    # pgformatter
    taplo
    typos-lsp
    harper

    docker-compose-language-service
    docker-ls
    ansible-language-server
    pylyzer
    ruff
    go
    # gopls
    rust-analyzer
    rustfmt
    deno
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    eslint
    nodePackages.prettier
    sqls
    # postgres-lsp

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Gnome settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "blue";
    };
    "org/gnome/shell" = {
      disable-user-extensions = true;
    };
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
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
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super>i" ];
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "flatpak run org.wezfurlong.wezterm";
      name = "open-terminal";
    };
  };

  programs.bash.enable = true;
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    # package = pkgs.gitFull;
    extraConfig = {
      credential.helper = "manager";
    };
  };

  # Neovim config - mainly plugins
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      gitsigns-nvim
      fzf-lua
      oil-nvim
      nvim-tree-lua
      nvim-web-devicons
      conform-nvim
      nvim-treesitter-context
      nvim-autopairs
      nvim-ts-autotag
      nvim-ts-context-commentstring
      nvim-highlight-colors
      blink-cmp
      markdown-preview-nvim
    ];

    # use `home.file` instead for whole nvim folder
    # extraLuaConfig = ''${builtins.readFile ./nvim/init.lua}'';
  };

  home.file = {
    # ".bashrc".source = ./.bashrc;
    ".gitconfig".source = ./.gitconfig;
    ".inputrc".source = ./.inputrc;
    ".tmux.conf".source = ./.tmux.conf;
    ".config/nvim/".source = ./nvim;
    # ".config/wezterm/wezterm.lua/".source = ./.wezterm.lua;
    # ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  };
  # home.sessionVariables = {
  #   EDITOR = "nvim"; # is this needed?
  # };

  programs.home-manager.enable = true;
}
