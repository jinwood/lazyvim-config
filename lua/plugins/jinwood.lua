local util = require("lspconfig.util")

return {
  -- 1. LSP SETTINGS
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 1. Disable the old vetur/vue_ls
        vue_ls = { enabled = false },

        -- 2. Volar (Template/Style engine)
        volar = {
          -- No need to hardcode root_dir unless you have a very specific monorepo setup
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },

        -- 3. Vtsls (The Brain)
        vtsls = {
          -- Ensure vue is in the filetypes so the plugin actually triggers
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
                        -- This path is the most reliable way to point to the Mason install on Mac
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
