local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
      end,
    })
  end
end

-- local root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
-- if not root_dir then
--   return
-- end

-- local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
-- local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

jdtls.start_or_attach({
  cmd = { "jdtls" },
  -- root_dir = root_dir,
  capabilities = capabilities,
  on_attach = on_attach,
})
