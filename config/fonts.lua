local wezterm = require('wezterm')

return {
   -- font = wezterm.font_with_fallback({
   --    {
   --       family = 'FiraCode Nerd Font Mono',
   --       weight = 'Regular',
   --       harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' },
   --    },
   --    -- { family = 'JetBrainsMono Nerd Font', weight = 'Regular' },
   --    -- { family = 'JetBrains Mono' },
   --    -- { family = 'FiraCode Nerd Font' },
   --    -- { family = 'Noto Sans SC:style=Regular' },
   --    -- { family = 'Noto Sans Mono CJK SC' },
   --}),
   font = wezterm.font(
      'FiraCode Nerd Font Mono',
      { weight = 'Regular', harfbuzz_features = { 'calt=1', 'clig=1', 'liga=1' } }
   ),

   font_size = 12,

   --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
   freetype_load_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
   freetype_render_target = 'Normal', ---@type 'Normal'|'Light'|'Mono'|'HorizontalLcd'
}
