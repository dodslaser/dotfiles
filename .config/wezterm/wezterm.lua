local dracula = require 'dracula'
local wezterm = require 'wezterm'

return {
    font_size = 11,
    font = wezterm.font_with_fallback {
      'MesloLGS Nerd Font Mono',
      'monospace'
    },
    colors = dracula,
    enable_scroll_bar = true,
    tab_bar_at_bottom = true,
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

