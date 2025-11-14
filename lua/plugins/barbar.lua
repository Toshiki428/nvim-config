return {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',
        'nvim-tree/nvim-web-devicons',
    },
    -- This init function disables barbar's automatic setup so that lazy.nvim can
    -- handle it.
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    -- These options will be passed to the setup function inside the config block.
    opts = {
        -- You can add any barbar options here, for example:
        -- animation = true,
    },
    config = function(_, opts)
        -- First, call the setup function with the options table.
        -- This is necessary because we are using a custom config function.
        require('barbar').setup(opts)

        -- Then, define your keymaps.
        local map = vim.keymap.set
        local map_opts = { noremap = true, silent = true }

        map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
        map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

        map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
        map('n', '<A-S-,>','<Cmd>BufferMovePrevious<CR>', opts)
        map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
        map('n', '<A-S-.>', '<Cmd>BufferMoveNext<CR>', opts)

        map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', map_opts)
        map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', map_opts)
        map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', map_opts)
        map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', map_opts)
        map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', map_opts)
        map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', map_opts)
        map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', map_opts)
        map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', map_opts)
        map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', map_opts)
        map('n', '<A-0>', '<Cmd>BufferLast<CR>', map_opts)
    end,
    version = '^1.0.0',
}
