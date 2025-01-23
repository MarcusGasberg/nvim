return {
  -- {
  --   'saghen/blink.cmp',
  --   -- optional: provides snippets for the snippet source
  --   dependencies = { 'rafamadriz/friendly-snippets' },
  --
  --   version = "v0.9.0",
  --   -- use a release tag to download pre-built binaries
  --   -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  --   -- build = 'cargo build --release',
  --   -- If you use nix, you can build from source using latest nightly rust with:
  --   -- build = 'nix run .#build-plugin',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = function()
  --     return {
  --       -- 'default' for mappings similar to built-in completion
  --       -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  --       -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  --       -- See the full "keymap" documentation for information on defining your own keymap.
  --       keymap = {
  --         ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --         ['<C-e>'] = { 'hide' },
  --
  --         ['<CR>'] = { 'accept', 'fallback' },
  --
  --         ['<S-Tab>'] = { 'select_prev', 'fallback' },
  --         ['<Tab>'] = { 'select_next', 'fallback' },
  --
  --         ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --         ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  --       },
  --
  --       appearance = {
  --         -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --         -- Useful for when your theme doesn't support blink.cmp
  --         -- Will be removed in a future release
  --         use_nvim_cmp_as_default = true,
  --         -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --         -- Adjusts spacing to ensure icons are aligned
  --         nerd_font_variant = 'mono'
  --       },
  --
  --       -- Default list of enabled providers defined so that you can extend it
  --       -- elsewhere in your config, without redefining it, due to `opts_extend`
  --       sources = {
  --         default = { 'lsp', 'path', 'snippets', 'buffer' },
  --       },
  --       completion = {
  --         list = { selection = 'auto_insert' },
  --       }
  --     }
  --   end,
  --   opts_extend = { "sources.default" }
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local buffer_opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", buffer_opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", buffer_opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", buffer_opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", buffer_opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", buffer_opts)
          vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", buffer_opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", buffer_opts)
          vim.keymap.set(
            "n",
            "<leader>vd",
            "<cmd>lua vim.diagnostic.open_float()<cr>",
            { desc = "View Diagnostics" }
          )
          vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", buffer_opts)
          vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", buffer_opts)
          vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", buffer_opts)
        end,
      })

      require("mason").setup()

      local servers = {
        lua_ls = {},
        vtsls = {
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
        }
      }

      local lspconfig = require('lspconfig')
      for server, config in pairs(servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
    },
    cond = not vim.g.vscode,
    config = function()
      local cmp = require("cmp");
      local cmp_select = { behavior = cmp.SelectBehavior.Insert }


      -- Setup completion engine
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!", "grep", "vimgrep", "Dispatch" },
            },
          },
        }),
      })

      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "buffer" },
        },
      })
    end
  }
}
