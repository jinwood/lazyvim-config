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
            typescript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
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

  {
    "mfussenegger/nvim-lint",
    opts = { linters_by_ft = { javascript = {}, typescript = {}, vue = {} } },
  },

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
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        file_ignore_patterns = { "node_modules", "%.DS_Store" },
      })
    end,
    keys = {
      { "<leader><leader>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root)" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root)" },
    },
  },
  { "nvim-neo-tree/neo-tree.nvim", opts = { filesystem = { filtered_items = { visible = true } } } },
  { "nvim-tree/nvim-web-devicons" },
  { "jinwood/nvim-guid" },
  { "webhooked/kanso.nvim", lazy = false, priority = 1000 },
  { "NLKNguyen/papercolor-theme", lazy = false, priority = 1000 },
  { "iamcco/markdown-preview.nvim" },
}
