local icons = require("utils.icons").icons
local fmt = require("utils.icons").fmt

return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({ paths = "./my-snippets" })
      end
    },

    build        = 'cargo build --release',
    cond         = not vim.g.vscode,

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts         = {
      keymap = {
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },

        ['<CR>'] = { 'accept', 'fallback' },

        ['<S-Tab>'] = { 'select_prev', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },

        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      snippets = { preset = "luasnip" },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lsp = {
            score_offset = 4,
          },
          snippets = {
            min_keyword_length = 2,
            score_offset = 3,
          },
          path = {
            min_keyword_length = 3,
            score_offset = 2,
          },
          buffer = {
            min_keyword_length = 5,
            score_offset = 1,
          },
        },
      },
      completion = {
        list = {
          selection = {
            auto_insert = function(ctx)
              return ctx.mode ~= 'cmdline'
            end,
            preselect = function(ctx)
              return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
            end
          }
        },
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    cond = not vim.g.vscode,
    config = function()
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help,
        { border = "rounded" })
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
      end, {
        desc = fmt("Fix", "Next [d]iagnostics"),
      })
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
      end, { desc = fmt("Fix", "Previous [d]iagnostics") })

      local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or "rounded"
        opts.max_width = opts.max_width or 80
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
      end

      -- Global diagnostic settings
      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        signs = {
          active = true,
          text = {
            [vim.diagnostic.severity.ERROR] = icons.Error,
            [vim.diagnostic.severity.WARN] = icons.Warn,
            [vim.diagnostic.severity.HINT] = icons.Hint,
            [vim.diagnostic.severity.INFO] = icons.Info,
          },
        },
        float = {
          header = "",
          source = true,
          border = "rounded",
          focusable = true,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local buffer_opts = { buffer = event.buf }
          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", buffer_opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", buffer_opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", buffer_opts)
          vim.keymap.set({ "n", "i" }, "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", buffer_opts)
          vim.keymap.set(
            "n",
            "<leader>vd",
            "<cmd>lua vim.diagnostic.open_float()<cr>",
            { desc = "View Diagnostics" }
          )
          vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", buffer_opts)
          vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", buffer_opts)

          vim.keymap.set("n", "<leader>=", "<cmd>lua require('conform').format()<cr>", buffer_opts)


          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client == nil then
            return
          end
          if client.server_capabilities.documentHighlightProvider then
            client.server_capabilities.documentHighlightProvider = false
          end
        end,
      })

      local mason_settings = require("mason.settings")
      local install_location = mason_settings.current.install_root_dir

      local servers = {
        lua_ls = {},
        eslint = {},
        tailwindcss = {
          cmd = { "tailwindcss-language-server", "--stdio" },
          filetypes = {
            "aspnetcorerazor",
            "astro",
            "astro-markdown",
            "angular",
            "blade",
            "django-html",
            "edge",
            "eelixir",
            "elixir",
            "heex",
            "ejs",
            "erb",
            "eruby",
            "gohtml",
            "haml",
            "handlebars",
            "hbs",
            "html",
            "html-eex",
            "heex",
            "jade",
            "leaf",
            "liquid",
            "markdown",
            "mdx",
            "mustache",
            "njk",
            "nunjucks",
            "php",
            "razor",
            "slim",
            "twig",
            "css",
            "less",
            "postcss",
            "sass",
            "scss",
            "stylus",
            "sugarss",
            "javascript",
            "javascriptreact",
            "reason",
            "rescript",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
          init_options = {
            userLanguages = {
              eelixir = "html-eex",
              elixir = "html-eex",
              eruby = "erb",
            },
          },
          on_new_config = function(new_config)
            if not new_config.settings then
              new_config.settings = {}
            end
            if not new_config.settings.editor then
              new_config.settings.editor = {}
            end
            if not new_config.settings.editor.tabSize then
              -- set tab size for hover
              new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
            end
          end,
          root_dir = require("lspconfig").util.root_pattern(
            "tailwind.config.js",
            "tailwind.config.ts",
            "postcss.config.js",
            "postcss.config.ts",
            "package.json",
            "node_modules",
            ".git"
          ),
          settings = {
            tailwindCSS = {
              experimental = {
                classRegex = {
                  { "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                  { "cx\\(((?:[^()]|\\([^()]*\\))*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
                },
              },
            },
          },
        },
        angularls = {
          root_dir = require("lspconfig").util.root_pattern(
            ".git",
            "pnpm-workspace.yaml",
            "pnpm-lock.yaml",
            "yarn.lock",
            "package-lock.json",
            "bun.lockb"
          ),
        },
        ts_ls = {
          root_dir = require("lspconfig").util.root_pattern(
            ".git",
            "pnpm-workspace.yaml",
            "pnpm-lock.yaml",
            "yarn.lock",
            "package-lock.json",
            "bun.lockb"
          ),
          typescript = {
            tsserver = {
              maxTsServerMemory = 12288,
            },
          },
          experimental = {
            completion = {
              entriesLimit = 3,
            },
          },
          capabilities = vim.tbl_deep_extend("force", require('blink.cmp').get_lsp_capabilities(), {
            textDocument = {
              rename = nil,
            },
          }),
          -- Add single-instance flag to prevent multiple instances
          single_file_support = false,
          flags = {
            debounce_text_changes = 150,
            allow_incremental_sync = true,
          },
        },
        jdtls = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xms1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-javaagent:" .. install_location .. "/share/jdtls/lombok.jar",
            "-jar",
            install_location .. "/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
            "-configuration",
            install_location .. "/share/jdtls/config",
            "-data",
            vim.fn.stdpath("data") .. "/lsp_servers/jdtls_workspace_" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          },
        },
        jsonls = {},
        ['cucumber_language_server'] = {},
        cssls = {}
      }
      local server_names = {}
      local n = 0

      for k, v in pairs(servers) do
        n = n + 1
        server_names[n] = k
      end

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = server_names,
      })

      local server_mappings = require("mason-lspconfig").get_mappings().lspconfig_to_package
      for server, config in pairs(servers) do
        local lsp_name = server_mappings[server]
        if lsp_name == nil then
          print("Server " .. server .. " not found in mason-lspconfig mappings")
          lsp_name = server
        end

        vim.lsp.config(lsp_name, config)
      end
    end,
  }
}
