{ config, pkgs, ... }:

{
  # Install language servers and other neovim-related packages
  home.packages = [
    pkgs.gopls
    pkgs.marksman
  ];

  # Enable the neovim program and manage it via home-manager
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nvim-lspconfig
    ];
    extraConfig = ''
      " Clipboard
      set clipboard=unnamedplus

      " Line numbers
      set number
      set relativenumber

      " LSP Config
      lua << EOF
      local lspconfig = require('lspconfig')
      lspconfig.gopls.setup{}
      lspconfig.marksman.setup{}

      -- Global mappings.
      -- See :help vim.diagnostic.open_float
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
      -- See :help vim.lsp.buf.hover
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      -- See :help vim.lsp.buf.definition
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
EOF
    '';
  };

  # Set environment variables for neovim
  home.sessionVariables = {
    VISUAL = "nvim";
    MYVIMRC = "$HOME/.config/nvim/init.vim";
  };

  # Set bash aliases for neovim
  programs.bash.shellAliases = {
    v = "nvim";
    vim = "nvim";
    vi = "nvim -u /dev/null";
  };
}
