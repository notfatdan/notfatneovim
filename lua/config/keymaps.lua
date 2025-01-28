-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "haskell", "lhaskell", "cabal" }, -- Restrict to Haskell file types
  callback = function()
    local ht = require("haskell-tools")
    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Set Haskell-specific keymaps
    vim.keymap.set("n", "<space>cl", vim.lsp.codelens.run, opts) -- Run codeLens
    vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts) -- Hoogle search
    vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts) -- Evaluate all code snippets
    vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts) -- Toggle GHCi REPL for the package
    vim.keymap.set("n", "<leader>rf", function()
      ht.repl.toggle(vim.api.nvim_buf_get_name(0)) -- Toggle GHCi REPL for the current buffer
    end, opts)
    vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts) -- Quit GHCi REPL
  end,
})
