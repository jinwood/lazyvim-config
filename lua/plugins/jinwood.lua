return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "default",
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = { "package%-lock%.json" },
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
}
