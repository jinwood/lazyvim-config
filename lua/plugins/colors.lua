return {
  {
    "aktersnurra/no-clown-fiesta.nvim",
    priority = 1000,
    opts = {
      -- Set transparent background
      transparency = false,
      dim_inactive = true,
    },
    config = function()
      vim.api.nvim_command("colorscheme no-clown-fiesta")
    end,
  },
  {
    "DanielEliasib/sweet-fusion",
  },
  {
    "yorickpeterse/vim-paper",
  },
}
