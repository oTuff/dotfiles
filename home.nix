{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  # https://search.nixos.org/packages
  home.packages = with pkgs; [
    pkgs.nixgl.nixGLIntel
    jq
    openvi
    foot
    tmux
    ripgrep
    fd
    fzy
    # tree-sitter
    git-credential-manager
    cloc
    # plantuml
    # visidata
    # aerc
    mpv
    yt-dlp
    feh
    luajit
    zig
    clang
    clang-tools
    # ollama
    copilot-language-server
    github-copilot-cli

    # ltex stuff
    texliveMedium
    pandoc
    haskellPackages.pandoc-crossref
    zathura

    # lsps, formatters and linters
    nixd
    nixfmt-rfc-style
    lua-language-server
    stylua
    # basedpyright
    pyright
    ty
    ruff
    odin
    ols
    go
    gopls
    gotools
    go-tools
    pkgsite
    cargo
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
    sqls
    sqruff
  ];

  # Gnome settings
  dconf.settings = import ./gnome.nix;

  # Bash etc.
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      source /etc/bashrc
      export PS1="\[\e[32m\]\w\[\e[0m\]\$ "
    '';
    initExtra = "PROMPT_COMMAND='history -a'";
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
    # extraConfig = {
    #   credential.helper = "manager";
    #   credential.credentialStore = "secretservice";
    #   # credential.helper = "~/.nix-profile/bin/git-credential-manager";
    #   # credential.credentialStore = "gnome-keyring";
    # };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "copilot.vim"
      "copilot-language-server"
      "github-copilot-cli"
    ];

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
            elixir
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
            heex
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
        # fzynvim = pkgs.vimUtils.buildVimPlugin {
        #   name = "nvim-fzy";
        #   version = "HEAD";
        #   src = builtins.fetchGit {
        #     url = "https://codeberg.org/mfussenegger/nvim-fzy";
        #   };
        # };
      in
      with pkgs.vimPlugins;
      [
        # nvim-treesitter.withAllGrammars
        gitsigns-nvim
        mini-files
        nvim-lspconfig
        nvim-treesitter-with-plugins
        nvim-treesitter-context
        nvim-ts-autotag
        nvim-autopairs
        copilot-vim # TODO: replace with copilot lsp
        telescope-nvim # TODO: replace with own minimal fzy integration
        # conform-nvim
        # fidget-nvim
        # fzynvim
        # csvview-nvim
        # otter-nvim
        # nvim-lint
        # nvim-highlight-colors
      ];

    # use `home.file` instead for whole nvim folder
    # extraLuaConfig = ''${builtins.readFile ./nvim/init.lua}'';
  };

  # home.shellAliases = {
  #   copilot = "ramalama serve ollama://qwen2.5-coder:1.5b -p 8012";
  # };

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
