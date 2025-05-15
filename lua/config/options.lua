-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wildignore:append({ "**/DS_Store" })
vim.opt.conceallevel = 0 -- don't hide my json strings
vim.g.root_spec = { "cwd" }
vim.g.snacks_animate = false

vim.g.terminal_env = {
  PATH = vim.env.PATH,
  NVM_DIR = vim.env.NVM_DIR,
}
