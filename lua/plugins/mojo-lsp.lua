return {
  require("lspconfig").mojo.setup({ cmd = { "mojo-lsp-server", "-I", "." } }),
}
