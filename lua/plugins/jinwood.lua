return {
  {
    "KijitoraFinch/nanode.nvim",
    priority = 1000,
    config = function()
      require("nanode").setup({
        transparent = false,
      })
    end,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nanode",
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- Improve statusline contrast while keeping default colorscheme
          vim.api.nvim_set_hl(0, "StatusLine", { fg = "#ffffff", bg = "#444444", bold = true })
          vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#cccccc", bg = "#333333" })
        end,
      }),
    },
  },
  {
    "stevearc/conform.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "package%-lock%.json", "node_modules", "yarn%.lock$", "%.DS_Store" },
        },
      })
      telescope.load_extension("fzf")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_by_name = {
            ".DS_Store",
          },
          never_show = {
            ".DS_Store",
          },
        },
      },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    strict = true,
    override_by_extension = {
      astro = {
        icon = "",
        color = "#EF8547",
        name = "astro",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  {
    "jinwood/nvim-guid",
  },
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "NLKNguyen/papercolor-theme",
    lazy = false,
    priority = 1000,
  },
  {
    "iamcco/markdown-preview.nvim",
  },
}
