return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      shell = "/bin/zsh",
      env = {
        NVM_DIR = vim.fn.expand("$HOME/.nvm"),
      },
      on_create = function(term)
        -- Wait for terminal job to start
        vim.defer_fn(function()
          if term.job_id then
            local nvm_script = [[
              export NVM_DIR="$HOME/.nvm"
              [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
              nvm use default
            ]]
            vim.api.nvim_chan_send(term.job_id, nvm_script .. "\n")
          end
        end, 100)
      end,
    },
  },
}
