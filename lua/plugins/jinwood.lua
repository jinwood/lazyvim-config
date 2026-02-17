local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        vue_ls = { enabled = false },

        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },

        vtsls = {
          filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          settings = {
            vtsls = {
              filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
              settings = {
                vtsls = {
                  tsserver = {
                    globalPlugins = {
                      {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.stdpath("data")
                          .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    },
  },

  -- 2. LINTING: Clear the manual setup to let the LSP handle it
  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { javascript = {}, typescript = {}, vue = {} } },
  },

  -- 3. THE REST OF YOUR PLUGINS
  { "akinsho/bufferline.nvim", opts = { options = { always_show_bufferline = true } } },
  {
    "KijitoraFinch/nanode.nvim",
    priority = 1000,
    config = function()
      require("nanode").setup({ transparent = false })
    end,
  },
  { "vhyrro/luarocks.nvim", priority = 1000, config = true },
  { "LazyVim/LazyVim", opts = { colorscheme = "default" } },
  { "stevearc/conform.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
    config = function()
      require("telescope").setup({ defaults = { file_ignore_patterns = { "node_modules", "%.DS_Store" } } })
      require("telescope").load_extension("fzf")
    end,
  },
  { "nvim-neo-tree/neo-tree.nvim", opts = { filesystem = { filtered_items = { visible = true } } } },
  { "nvim-tree/nvim-web-devicons" },
  { "jinwood/nvim-guid" },
  { "webhooked/kanso.nvim", lazy = false, priority = 1000 },
  { "NLKNguyen/papercolor-theme", lazy = false, priority = 1000 },
  { "iamcco/markdown-preview.nvim" },
}
