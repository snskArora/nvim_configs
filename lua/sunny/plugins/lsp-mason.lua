return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "mfussenegger/nvim-lint",
    "mhartington/formatter.nvim"
  },
  config = function()
    -- import mason
    local mason = require("mason")

    -- import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "azure_pipelines_ls",
        "bashls",
        "clangd",
        "cmake",
        "dockerls",
        "lua_ls",
        "harper_ls", -- intention: GO, markdown
        "helm_ls",
        "jsonls",
        -- "nginx_language_server", -- installation error to be fixed in future
        "powershell_es",
        "puppet",
        "pylsp",
        "pyright",
        -- "sqlls", -- installation error to be fixed in future
        "rnix",
        "terraformls",
        "grammarly",
        -- "gitlab_ci_ls", -- installation error to be fixed in future
        "yamlls",
      },
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint",
      },
    })
  end,
}
