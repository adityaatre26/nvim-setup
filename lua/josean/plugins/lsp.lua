return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "v",
            package_pending = "->",
            package_uninstalled = "x",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        -- LSP servers that mason will automatically install
        ensure_installed = {
          -- Go
          "gopls",
          -- JavaScript / TypeScript / React / Next.js
          "ts_ls",
          -- HTML
          "html",
          -- CSS
          "cssls",
          -- Tailwind CSS
          "tailwindcss",
          -- JSON
          "jsonls",
          -- YAML
          "yamlls",
          -- Dockerfile
          "dockerls",
          -- Docker Compose
          "docker_compose_language_service",
          -- Lua (for your Neovim config)
          "lua_ls",
          -- ESLint
          "eslint",
          -- Emmet (HTML/CSS abbreviations)
          "emmet_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Enhanced capabilities from nvim-cmp (enables LSP-driven autocompletion)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Keymaps that activate when an LSP attaches to a buffer
      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, silent = true }

        -- Go to declaration
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        -- Go to definition
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        -- Show hover info
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover info" }))
        -- Go to implementation
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        -- Show signature help
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Show signature help" }))
        -- Go to type definition
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
        -- Rename symbol
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
        -- Code actions
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
        -- Show references
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
        -- Show diagnostics for line
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show line diagnostics" }))
        -- Go to previous diagnostic
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
        -- Go to next diagnostic
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
        -- Restart LSP
        vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", opts, { desc = "Restart LSP" }))
      end

      -- Diagnostic signs in the gutter
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- ═══════════════════════════════════════════
      -- Server configurations
      -- ═══════════════════════════════════════════

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      -- TypeScript / JavaScript / React / Next.js
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- ESLint
      lspconfig.eslint.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Tailwind CSS
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- JSON
      lspconfig.jsonls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- YAML
      lspconfig.yamlls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          yaml = {
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
            },
            validate = true,
            completion = true,
          },
        },
      })

      -- Dockerfile
      lspconfig.dockerls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Docker Compose
      lspconfig.docker_compose_language_service.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Emmet
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
      })

      -- Lua (configured for Neovim development)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" }, -- recognize 'vim' global
            },
            completion = {
              callSnippet = "Replace",
            },
            workspace = {
              library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "/lua"] = true,
              },
            },
          },
        },
      })
    end,
  },
}
