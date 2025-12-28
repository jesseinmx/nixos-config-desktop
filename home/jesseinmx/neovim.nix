{ config, pkgs, ... }:

{
  # Install language servers and other neovim-related packages
  home.packages = [
    pkgs.gopls
    pkgs.marksman
    pkgs.markdownlint-cli
  ];

  # Enable the neovim program and manage it via home-manager
  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.nvim-lspconfig
      (pkgs.vimPlugins.nvim-treesitter.withAllGrammars)
      pkgs.vimPlugins.none-ls-nvim
    ];
    extraConfig = ''
      " Clipboard
      set clipboard=unnamedplus

      " Line numbers
      set number
      set relativenumber
    '';
    extraLuaConfig = ''
      -- LSP Config
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

      -- Treesitter setup
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
      }

      -- None-ls setup
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.markdownlint,
        },
      })

      -- 1. Enable Virtual Text (Text at end of line)
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
      })

      -- 2. specific keymap to show error message (Press 'gl' to show error)
      vim.keymap.set('n', 'gl', vim.diagnostic.open_float)

      -- 3. (Optional) Auto-show error window when cursor stops moving
      vim.o.updatetime = 250 -- faster update time
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function ()
          vim.diagnostic.open_float(nil, {focus=false})
        end
      })
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
