return {
  {
    "danilamihailov/beacon.nvim",
    event = "VeryLazy",
    keys = {
      { "n", "n:Beacon<cr>", desc = "Beacon Search Term Next" },
      { "N", "n:Beacon<cr>", desc = "Beacon Search Term Prev" },
      { "*", "*:Beacon<cr>", desc = "Beacon Cursor Term Next" },
      { "#", "#:Beacon<cr>", desc = "Beacon Cursor Term Prev" },
    },
    config = function()
      -- beacon_minimal_jump = 2,
      vim.g.beacon_shrink = 0
      vim.g.beacon_fade = 1
      vim.g.beacon_size = 777
    end,
  },
}
