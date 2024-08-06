local wezterm = require('wezterm')
local nf = wezterm.nerdfonts

local TAB_LEFT_SIDE = nf.ple_left_half_circle_thick --[[ '' ]]
local TAB_RIGHT_SIDE = nf.ple_right_half_circle_thick --[[ '' ]]

local M = {}

M.cells = {}

M.colors = {
   default = {
      bg = '#7c6f64',
      fg = '#1d2021',
   },
   is_active = {
      bg = '#d79921',
      fg = '#1d2021',
   },
   hover = {
      bg = '#7c6f64',
      fg = '#1d2021',
   },
}

M.stripbase = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

M.set_title = function(process_name, static_title, active_title, max_width, inset)
   local title
   local icon
   inset = inset or 6

   if process_name == 'zsh' then
      icon = nf.cod_terminal .. ' '
   elseif process_name == 'bash' then
      icon = nf.cod_terminal_bash .. ' '
   elseif process_name == 'nvim' then
      icon = nf.custom_vim .. ' '
   elseif process_name == 'tmux' then
      icon = nf.cod_terminal_tmux .. ' '
   else
      icon = nf.fa_hourglass_half .. ' '
   end

   title = icon .. process_name .. ' ~ ' .. ' '
   if process_name:len() > 0 and static_title:len() == 0 then
      title = icon .. process_name .. ' ~ ' .. ' '
   elseif static_title:len() > 0 then
      title = icon .. static_title .. ' ~ ' .. ' '
   else
      title = icon .. active_title .. ' ~ ' .. ' '
   end

   if title:len() > max_width - inset then
      local diff = title:len() - max_width + inset
      title = wezterm.truncate_right(title, title:len() - diff)
   end

   return title
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
M.push = function(bg, fg, attribute, text)
   table.insert(M.cells, { Background = { Color = bg } })
   table.insert(M.cells, { Foreground = { Color = fg } })
   table.insert(M.cells, { Attribute = attribute })
   table.insert(M.cells, { Text = text })
end

M.setup = function()
   wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
      M.cells = {}

      local bg
      local fg
      local process_name = M.stripbase(tab.active_pane.foreground_process_name)
      local title = M.set_title(process_name, tab.tab_title, tab.active_pane.title, max_width)

      if tab.is_active then
         bg = M.colors.is_active.bg
         fg = M.colors.is_active.fg
      elseif hover then
         bg = M.colors.hover.bg
         fg = M.colors.hover.fg
      else
         bg = M.colors.default.bg
         fg = M.colors.default.fg
      end

      -- Left semi-circle
      M.push(fg, bg, { Intensity = 'Bold' }, TAB_LEFT_SIDE)

      -- Title
      M.push(bg, fg, { Intensity = 'Bold' }, ' ' .. title)

      -- Right padding
      M.push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- Right semi-circle
      M.push(fg, bg, { Intensity = 'Bold' }, TAB_RIGHT_SIDE)

      return M.cells
   end)
end

return M
