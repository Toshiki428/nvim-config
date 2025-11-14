return {
  'akinsho/toggleterm.nvim',
  version = "*",
  opts = {
    -- size can be a number or a function which is passed the current terminal
    size = 20,
    open_mapping = {[[<c-\>]], [[<C-¥>]]},
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- 'dark' theme, see :h toggleterm-shading
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    float_opts = {
      -- The border key is the same as 'border' for vim.api.nvim_open_win
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = 'curved',
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    function _LAZYGIT_TOGGLE()
      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
          border = 'single',
          width = 120,
          height = 35,
          winblend = 0,
        }
      })
      lazygit:toggle()
    end

    vim.api.nvim_set_keymap('n', '<leader>g', '<Cmd>lua _LAZYGIT_TOGGLE()<CR>', { noremap = true, silent = true })
  end,
}
