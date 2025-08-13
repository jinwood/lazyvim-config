local function is_monorepo()
  local apps_ok = vim.loop.fs_stat("apps")
  local packages_ok = vim.loop.fs_stat("packages")
  return apps_ok and packages_ok and apps_ok.type == "directory" and packages_ok.type == "directory"
end

-- truncate long paths.
local function truncate(str, max_len)
  if str:len() > max_len then
    local head_len = math.floor((max_len - 3) / 2)
    local tail_len = max_len - 3 - head_len
    return str:sub(1, head_len) .. "..." .. str:sub(str:len() - tail_len + 1)
  end
  return str
end

return {
  {
    "akinsho/bufferline.nvim",
    enabled = is_monorepo,
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
