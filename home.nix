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
    tmux
    ripgrep
    fd
    fzf
    git-credential-manager
    tree-sitter
    postgresql
    aider-chat
    pkgs.nixgl.nixGLIntel

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
    # pylyzer
    basedpyright
    ruff
    go
    gopls
    gotools
    rust-analyzer
    rustfmt
    deno
    typescript-language-server
    vscode-langservers-extracted
    tailwindcss-language-server
    eslint
    nodejs
    nodePackages.prettier
    bash-language-server
    shellcheck
    shfmt
    yaml-language-server
    taplo
    marksman
    typos-lsp
    harper
    # ltex-ls
    ltex-ls-plus
    texlab
    emmet-language-server
    ansible-language-server
    sqls
    # pgformatter
    # postgres-lsp
    # docker-compose-language-service
    # docker-ls

    # (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  # fonts.fontconfig.enable = true;

  # nixpkgs.config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "copilot.vim"
  #   ];

  # Gnome settings
  dconf.settings = import ./gnome.nix;

  # Bash etc.
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
      mini-files
      mini-icons
      conform-nvim
      nvim-lint
      # nvim-tree-lua
      # nvim-web-devicons
      # oil-nvim
      nvim-treesitter-context
      nvim-ts-autotag
      nvim-autopairs
      # nvim-ts-context-commentstring
      nvim-highlight-colors
      markdown-preview-nvim
      minuet-ai-nvim
      # blink-cmp
      # mini-completion
      # copilot-vim
      # fidget-nvim
      csvview-nvim
    ];

    # use `home.file` instead for whole nvim folder
    # extraLuaConfig = ''${builtins.readFile ./nvim/init.lua}'';
  };

  home.shellAliases = {
    copilot = "ramalama serve ollama://qwen2.5-coder:1.5b -p 8012";
  };

  home.file = {
    ".gitconfig".source = ./.gitconfig;
    ".inputrc".source = ./.inputrc;
    ".tmux.conf".source = ./.tmux.conf;
    ".config/nvim/".source = config.lib.file.mkOutOfStoreSymlink ~/dotfiles/nvim; # use impure
    ".config/foot/foot.ini".source = ./foot.ini;
    # ".wezterm.lua/".source = ./.wezterm.lua;
    # ".config/wezterm/wezterm.lua/".source = ./.wezterm.lua;
    # ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  };

  programs.home-manager.enable = true;
}
