return {
    'hermitmaster/nvim-kitty-navigator',
    lazy = false,
    run = './install',
    config = function()
        require('nvim-kitty-navigator').setup {}
    end
}
