{
  config,
  pkgs,
  ...
}:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  # https://search.nixos.org/packages
  home.packages = with pkgs; [
    pkgs.nixgl.nixGLIntel
    foot
    tmux
    ripgrep
    fd
    fzf
    tree-sitter
    git-credential-manager
    cloc
    plantuml
    visidata
    # aerc
    mpv
    yt-dlp

    # ltex stuff
    texliveMedium
    pandoc
    haskellPackages.pandoc-crossref
    zathura

    # lsp and formatters
    nixd
    nixfmt-rfc-style
    lua-language-server
    stylua
    # basedpyright
    pyright
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

    plugins =
      let
        # https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
        nvim-treesitter-with-plugins = pkgs.vimPlugins.nvim-treesitter.withPlugins (
          treesitter-plugins: with treesitter-plugins; [
            bash
            bibtex
            c
            comment
            cpp
            css
            csv
            # diff
            # dockerfile
            # editorconfig
            # elixir
            # git_config
            # git_rebase
            # gitattributes
            # gitcommit
            # gitignore
            go
            # gomod
            # gosum
            gotmpl
            # gowork
            html
            # http
            # ini
            javascript
            jsdoc
            json
            # jsonc
            latex
            # llvm
            lua
            luadoc
            luap
            # make
            markdown
            markdown_inline
            nix
            python
            # readline
            regex
            ron
            rust
            sql
            terraform
            # tmux
            toml
            tsx
            typescript
            vim
            vimdoc
            xml
            yaml
          ]
        );
      in
      with pkgs.vimPlugins;
      [
        # nvim-treesitter.withAllGrammars
        nvim-treesitter-with-plugins
        nvim-lspconfig
        gitsigns-nvim
        fzf-lua
        mini-files
        mini-icons
        conform-nvim
        nvim-treesitter-context
        nvim-ts-autotag
        nvim-autopairs
        csvview-nvim
        minuet-ai-nvim
        # nvim-lint
        # nvim-highlight-colors
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
