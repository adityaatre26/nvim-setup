return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,

          -- Accept & cycle suggestions safely
          keymap = {
            accept = "<C-l>",   -- Accept suggestion
            next   = "<C-j>",   -- Next suggestion
            prev   = "<C-k>",   -- Previous suggestion
            dismiss = "<Esc>",  -- Dismiss suggestion
          },
        },

        panel = {
          enabled = false, -- We don't need the panel
        },

        filetypes = {
          ["*"] = true, -- Enable everywhere
        },

        copilot_node_command = "node", -- Make sure node is in your PATH
      })
    end,
  },
}

