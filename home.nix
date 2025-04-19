{
  config,
  pkgs,
  lib,
  nixgl,
  ...
}:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    foot
    ripgrep
    fd
    pkgs.nixgl.nixGLIntel
    git-credential-manager
    tmux
    tree-sitter
    fzf
    postgresql

    # ltex stuff
    texliveFull
    pandoc
    haskellPackages.pandoc-crossref
    zathura

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
    ltex-ls
    texlab
    emmet-ls
    nodejs
    emmet-language-server

    docker-compose-language-service
    docker-ls
    ansible-language-server
    pylyzer
    basedpyright
    ruff
    go
    gopls
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

  # fonts.fontconfig.enable = true;
  #
  # # GTK configuration
  # gtk = {
  #   enable = true;
  #   font = {
  #     name = "DejaVu Sans";
  #     size = 11;
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.adwaita-icon-theme;
  #   };
  # };

  # Gnome settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      accent-color = "blue";
    };
    # "org/gnome/shell" = {
    #   disable-user-extensions = true;
    # };
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
      command = "foot";
      name = "open-terminal";
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = "source /etc/bashrc";
  };
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
      nvim-tree-lua
      nvim-web-devicons
      oil-nvim
      conform-nvim
      nvim-treesitter-context
      nvim-ts-autotag
      nvim-ts-context-commentstring
      nvim-highlight-colors
      markdown-preview-nvim
      minuet-ai-nvim
      # blink-cmp
      # nvim-autopairs
      # copilot-vim
      # fidget-nvim
    ];

    # use `home.file` instead for whole nvim folder
    # extraLuaConfig = ''${builtins.readFile ./nvim/init.lua}'';
  };

  # nixpkgs.config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "copilot.vim"
  #   ];

  home.shellAliases = {
    copilot = "ramalama serve ollama://qwen2.5-coder:1.5b -p 8012";
  };

  home.file = {
    ".gitconfig".source = ./.gitconfig;
    ".inputrc".source = ./.inputrc;
    ".tmux.conf".source = ./.tmux.conf;
    ".config/nvim/".source = ./nvim;
    ".config/foot/foot.ini".source = ./foot.ini;
    # ".wezterm.lua/".source = ./.wezterm.lua;
    # ".config/wezterm/wezterm.lua/".source = ./.wezterm.lua;
    # ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  };

  # xdg.configFile."nvim" = {
  #   source = ./nvim;
  #   recursive = true; # Make sure this is set to true
  #   force = true;
  # };

  programs.home-manager.enable = true;
}
