return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'theprimeagen/harpoon'
        },
        keys = {
            { '<leader>tb', '<Cmd>Telescope buffers<CR>',       desc = 'Buffers' },
            { '<leader>tf', '<Cmd>Telescope find_files<CR>',    desc = 'Files' },
            { '<leader>tF', '<Cmd>Telescope file_browser<CR>',  desc = 'File browser' },
            { '<leader>tG', '<Cmd>Telescope live_grep<CR>',     desc = 'Live grep' },
            { '<leader>th', '<Cmd>Telescope harpoon marks<CR>', desc = 'Harpoon' },
            { '<leader>tk', '<Cmd>Telescope keymaps<CR>',       desc = 'Keymaps' },
            { '<leader>tR', '<Cmd>Telescope registers<CR>',     desc = 'Registers' },
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup {}

            -- extensions
            local extensions = {
                'harpoon',
                'file_browser',
            }

            for _, extension in ipairs(extensions) do
                telescope.load_extension(extension)
            end
        end
    },
    {
		'nvim-telescope/telescope-file-browser.nvim',
		dependencies = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim'
		}
	},
}
