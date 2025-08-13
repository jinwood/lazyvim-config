local function is_monorepo()
  local apps_ok = vim.loop.fs_stat("apps")
  local packages_ok = vim.loop.fs_stat("packages")
  return apps_ok and packages_ok and apps_ok.type == "directory" and packages_ok.type == "directory"
end

return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = is_monorepo,
    opts = {
      defaults = {
        path_display = { "truncate" },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    enabled = is_monorepo,
    opts = {
      options = {
        -- Use a custom function to format the buffer name in the tabline
        name_formatter = function(buf)
          -- buf.path is the full path to the file in the buffer
          if buf.path == "" then
            return "[No Name]"
          end

          -- Get the path relative to the current working directory (project root)
          local relative_path = vim.fn.fnamemodify(buf.path, ":.")

          -- Check if the path is inside 'apps' or 'packages'
          if relative_path:match("^apps/") or relative_path:match("^packages/") then
            local parts = vim.split(relative_path, "/")
            if #parts >= 2 then
              -- Construct a new name, e.g., "[agent] .../stores/campaignStore.ts"
              -- This shows the app/package name prominently.
              local new_name = string.format("[%s] %s", parts[2], vim.fn.fnamemodify(buf.path, ":t"))
              return new_name
            end
          end
          -- Fallback to the default: just the filename
          return vim.fn.fnamemodify(buf.path, ":t")
        end,
      },
    },
  },
}
