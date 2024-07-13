local disable_semantic_highlighting = {
  zig = false, -- zigs is sometimes very slow, keeping enabled for now
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_highlighting[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end

    client.server_capabilities.documentHighlightProvider = nil
  end,
})
