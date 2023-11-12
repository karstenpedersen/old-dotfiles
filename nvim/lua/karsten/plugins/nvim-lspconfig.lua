local servers = {
    ['tailwindcss'] = {},
    ['svelte'] = {},
    ['astro'] = {},
    -- ['prettierd'] = {},
    ['cssls'] = {},
    ['html'] = {},
    ['lua_ls'] = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                },
                workspace = {
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.stdpath('config') .. '/lua'] = true
                    }
                }
            }
        }
    },
    ['rust_analyzer'] = {},
    ['tsserver'] = {},
    ['asm_lsp'] = {},
    ['marksman'] = {},
    ['texlab'] = {
        
    }
}

local servers_key = vim.tbl_keys(servers)

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        { 'williamboman/mason.nvim', config = true },
        {
            'williamboman/mason-lspconfig.nvim',
            opts = {
                ensure_installed = servers_key
            }
        },
        'glepnir/lspsaga.nvim',
        'jose-elias-alvarez/null-ls.nvim',
        'jose-elias-alvarez/typescript.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'rrethy/vim-illuminate'
    },
    opts = {},
    config = function(_, opts)
        vim.diagnostic.config(opts)

        local lspconfig = require('lspconfig')

        vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })

            -- Mappings
            local opts = { silent = true, noremap = true, buffer = bufnr }

            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
            vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<space>f', function()
                vim.lsp.buf.format { async = true }
            end, opts)

            -- Language keybinds
            if client.name == 'tsserver' then
                vim.keymap.set('n', '<leader>rf', ':TypescriptRenameFile<CR>')
            elseif client.name == "texlab" then
                vim.keymap.set('n', '<leader>K', '<plug>(vimtex-doc-package)', opts) 
            end

            -- Setup word highlighting
            require('illuminate').on_attach(client)
        end

        -- Setup language servers
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        for server, opts in pairs(servers) do
            opts = vim.tbl_deep_extend('force', opts, {
                capabilities = capabilities,
                on_attach = on_attach
            })

            if server == 'tsserver' then
                require('typescript').setup({
                    server = opts
                })
            else
                lspconfig[server].setup(opts)
            end
        end

        -- Setup null-ls
        local nls = require('null-ls')
        local builtin = nls.builtins
        nls.setup({
            sources = {
                builtin.formatting.stylua,
                builtin.formatting.prettier
                -- TODO - Look at null-ls
            }
        })
    end
}
