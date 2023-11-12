return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	event = {
		'BufReadPost',
		'BufNewFile'
	},
	dependencies = {
		'mrjones2014/nvim-ts-rainbow',
	},
	opts = {
		ensure_installed = {
			'lua',
			'rust',
			'javascript',
			'typescript',
			'json',
			'html',
			'tsx',
			'yaml',
			'svelte',
			'markdown',
			'css',
			'scss',
			'svelte',
			'html',
            'bibtex',
            'latex'
		},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true
		}
	},
	config = function(_, opts)
		require('nvim-treesitter.configs').setup(opts)
	end
}
