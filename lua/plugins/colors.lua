return {
  {
    "aktersnurra/no-clown-fiesta.nvim",
  },
  {
    "DanielEliasib/sweet-fusion",
  },
  {
    "yorickpeterse/vim-paper",
    priority = 1000,
    opts = {
      -- Set transparent background
      transparency = false,
      dim_inactive = true,
    },
    config = function()
      vim.api.nvim_command("colorscheme paper")
    end,
  },
}
