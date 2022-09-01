local wezterm = require 'wezterm'
local gui = wezterm.gui
local dracula_custom, _ = wezterm.color.load_scheme(wezterm.config_dir .. '/colors/dracula.toml')

dracula_custom.selection_fg = '#282a36'
dracula_custom.selection_bg = '#f8f8f2'


if(gui.screens()['main']['height'] <= 1440)
then
    font_size = 9
else
    font_size = 11
end

return {
    font_size = font_size,
    font = wezterm.font_with_fallback {
      'MesloLGS Nerd Font Mono',
      'monospace'
    },
    color_schemes = {
        ['Dracula (Custom)'] = dracula_custom,
    },
    color_scheme = 'Dracula (Custom)',
    enable_scroll_bar = true,
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,
    warn_about_missing_glyphs = false,
    default_cursor_style = "BlinkingUnderline",
    cursor_blink_rate = 600,
    
    keys = {
        {
            key = "d",
            mods = "SUPER",
            action = wezterm.action.SplitVertical { domain="CurrentPaneDomain" },
        },
        {
            key = "d",
            mods = "SUPER|SHIFT",
            action = wezterm.action.SplitHorizontal {domain="CurrentPaneDomain"},
        },
    },
}
