return {
  -- Correctly setup lspconfig for C# 🚀
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ensure mason installs the server
        omnisharp = {},
      },
      setup = {
        omnisharp = function(_, _)
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "omnisharp" then
              local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
              for i, v in ipairs(tokenModifiers) do
                tokenModifiers[i] = v:gsub(" ", "_")
              end
              local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
              for i, v in ipairs(tokenTypes) do
                tokenTypes[i] = v:gsub(" ", "_")
              end
            end
          end)
          return false
        end,
      },
    },
  },
}
