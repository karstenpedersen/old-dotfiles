return {
	'theprimeagen/harpoon',
	init = function()
		local mark = require('harpoon.mark')
		local ui = require('harpoon.ui')

		vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon file', silent = true, noremap = true })
		vim.keymap.set('n', '<leader>1', function() ui.nav_file(1) end, { desc = 'Harpoon mark 1', silent = true, noremap = true })
		vim.keymap.set('n', '<leader>2', function() ui.nav_file(2) end, { desc = 'Harpoon mark 2', silent = true, noremap = true })
		vim.keymap.set('n', '<leader>3', function() ui.nav_file(3) end, { desc = 'Harpoon mark 3', silent = true, noremap = true })
		vim.keymap.set('n', '<leader>4', function() ui.nav_file(4) end, { desc = 'Harpoon mark 4', silent = true, noremap = true })
	end
}
