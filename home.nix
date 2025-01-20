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
    # dev tools
    # (config.lib.nixGL.wrap alacritty)
    tmux
    # git
    # git-lfs
    # git-credential-manager
    direnv
    zoxide
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
  # programs.direnv.enable = true;

  # same as the above in `home.packages`
  # programs.alacritty = {
  #   enable = true;
  #   package = config.lib.nixGL.wrap pkgs.alacritty;
  # };

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
    ".wezterm.lua/".source = ./.wezterm.lua;
    # ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  };
  # home.sessionVariables = {
  # PROMPT_COMMAND = "history -a"; # not needed when i have tmux conf
  # EDITOR = "nvim"; # is this needed?
  # };

  programs.home-manager.enable = true;
}
