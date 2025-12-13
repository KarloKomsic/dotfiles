return {
  {
    'barrett-ruth/live-server.nvim',
    build = 'pnpm add -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true,
    keys = {
      { '<leader>ls', '<cmd>LiveServerStart<CR>', desc = 'Start Live Server' },
      {
        '<leader>lS',
        '<cmd>LiveServerStop<CR>',
        desc = 'Stop Live Server',
      },
    },
  },
}
