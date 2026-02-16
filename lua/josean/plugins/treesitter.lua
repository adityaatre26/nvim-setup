
return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",  -- Pin to working version
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      -- your existing config unchanged
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = { "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "markdown", "markdown_inline", "bash", "lua", "vim", "dockerfile", "gitignore", "c" },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}

