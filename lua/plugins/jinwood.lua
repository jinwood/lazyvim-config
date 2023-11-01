return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettierd")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },
  {
    "Exafunction/codeium.vim",
    config = function()
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
    end,
  },
  {
    "prisma/vim-prisma",
    ft = "prisma",
    config = function()
      vim.g.prisma_formatter = "prettier"
    end,
  },
  {
    "vim-scripts/gruvbox",
    config = function()
      vim.o.background = "dark"
    end,
    lazy = false,
    priority = 1000,
  },
}
