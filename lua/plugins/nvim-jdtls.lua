return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {
      setup = {
        jdtls = function(_, opts)
          vim.api.nvim_create_autocmd("FileType", {
            pattern = "java",
            callback = function()
              -- Attach basic LSP functionality when opening a Java file
              require("lazyvim.util").on_attach(function(_, buffer)
                -- Basic formatting command (if needed)
                vim.keymap.set(
                  "n",
                  "<leader>cf",
                  "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
                  { buffer = buffer, desc = "Format" }
                )
              end)

              -- Use project name to create workspace directory
              local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
              local workspace_dir = vim.fn.stdpath("data") .. "/workspace/" .. project_name

              -- Define the language server configuration (no custom cmd needed)
              local config = {
                -- No need for cmd since nvim-jdtls will handle it
                root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }), -- Project root
                settings = {
                  java = {}, -- Add additional Java-specific settings if needed
                },
              }

              -- Start or attach the language server
              require("jdtls").start_or_attach(config)
            end,
          })
          return true
        end,
      },
    },
  },
}
