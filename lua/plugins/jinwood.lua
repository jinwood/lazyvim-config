local project_name = "opacampaignmanagementweb"

local function is_in_project()
  local cwd = vim.fn.getcwd()
  return vim.startswith(cwd, project_name)
end

local function get_project_root()
  local cwd = vim.fn.getcwd()
  local root = vim.fs.find({ ".eslintrc.js" }, {
    upward = true,
    path = cwd,
  })[1]
  if root then
    return vim.fs.dirname(root)
  end
  return cwd
end

return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  },
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
      colorscheme = "default",
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
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        javascriptreact = { "eslint" },
        typescriptreact = { "eslint" },
        vue = { "eslint" },
      },
    },
    config = function(_, opts)
      -- Only apply this configuration if we're in the target project
      if not is_in_project() then
        return
      end

      local lint = require("lint")

      -- Set up linters by filetype
      lint.linters_by_ft = opts.linters_by_ft or {}

      -- Configure eslint to use the correct root directory
      lint.linters.eslint.cmd = "eslint"
      lint.linters.eslint.args = {
        "--format",
        "json",
        "--stdin",
        "--stdin-filename",
        function()
          return vim.api.nvim_buf_get_name(0)
        end,
      }

      -- Override the cwd function to find the project root
      local original_eslint = lint.linters.eslint
      lint.linters.eslint = vim.tbl_extend("force", original_eslint, {
        cwd = function()
          local current_file = vim.api.nvim_buf_get_name(0)

          -- Only apply if the file is in the target project
          if not current_file:match(project_name) then
            return vim.fn.getcwd()
          end

          -- Find the root directory containing .eslintrc.js
          local root = vim.fs.find({ ".eslintrc.js", ".eslintrc.json", ".git" }, {
            upward = true,
            path = current_file,
          })[1]

          if root then
            return vim.fs.dirname(root)
          end

          -- Fallback to detected project root
          return get_project_root()
        end,
      })

      -- Set up autocommands for linting
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          -- Only lint if we're in the target project
          local current_file = vim.api.nvim_buf_get_name(0)
          if current_file:match(project_name) then
            require("lint").try_lint()
          end
        end,
      })
    end,
  },
}
