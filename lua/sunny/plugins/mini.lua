return {
  {
    'echasnovski/mini.icons',
    version = '*',
    lazy = false,
    config = function ()
      require('mini.icons').setup()
    end,
  },
  {
    'echasnovski/mini.animate', 
    event = { "BufReadPre", "BufNewFile" },
    version = '*',
    lazy = false,
    config = function ()
      require('mini.animate').setup()
    end,
  },
}
