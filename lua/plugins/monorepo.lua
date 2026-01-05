local function is_monorepo()
  local apps_ok = vim.loop.fs_stat("apps")
  local packages_ok = vim.loop.fs_stat("packages")
  return apps_ok and packages_ok and apps_ok.type == "directory" and packages_ok.type == "directory"
end

return {
  {
    "akinsho/bufferline.nvim",
    enabled = is_monorepo(),
    opts = {
      options = {
        max_name_length = 20,
        name_formatter = function(buf)
          if buf.path == "" then
            return "[No Name]"
          end
          local relative_path = vim.fn.fnamemodify(buf.path, ":.")
          if relative_path:match("^apps/") or relative_path:match("^packages/") then
            local parts = vim.split(relative_path, "/")
            if #parts >= 2 then
              return string.format("%s/%s", parts[2], vim.fn.fnamemodify(buf.path, ":t"))
            end
          end
          return vim.fn.fnamemodify(buf.path, ":t")
        end,
      },
    },
  },
}
