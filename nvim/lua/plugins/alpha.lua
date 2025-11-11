return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  enabled = true,
  init = false,
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = [[
⠀⠀⠀⠀⠀⠀⠀⣰⣾⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣠⣿⣿⣟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣴⣿⡿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣠⠾⠋⠁⠀⣿⣿⣿⣥⣶⣤⣤⣀⠀⣀⠀⢀⣀⣀⣀⣠⣤⣤⣤⣶⣦⣄⡀
⠀⠀⠀⢀⣠⣤⣶⣿⣿⣿⣿⠿⠿⠟⠋⢸⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⣿⠷
⢴⣶⣿⣿⣿⡿⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⣿⣿⣿⠉⠁⠀⠀⠀⢰⣿⣿⣿⠏⠀
⠀⠉⠙⠋⠀⣰⣿⣿⣿⣿⡿⢿⣿⣷⡄⠀⢸⣿⣿⡇⠀⠀⠀⢀⣾⣿⣿⡿⠀⠀
⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⡇⠀⠈⠉⠁⠀⢀⣿⣿⣷⣴⣶⣶⣾⣿⣿⣿⠁⠀⠀
⠀⠀⠀⣰⣿⠿⠃⢸⣿⣿⡇⠀⠀⠀⠀⠀⠈⠻⢿⣿⡿⠿⠟⠿⠛⠛⠁⠀⠀⠀
⠀⣀⠼⠛⠁⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠈⠁⠀⠀⠀⠀⠀⢸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
    ]]
    dashboard.section.buttons.val = {
    }
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.opts.layout[1].val = 4
    dashboard.section.header.opts.hl = "AlphaHeader"
    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)
  end,
}
