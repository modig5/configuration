{ ... }: {
  home.file."Library/Application Support/com.mitchellh.ghostty/config".text = ''
    theme = Gruvbox Dark
    font-family = JetBrainsMono Nerd Font
    font-size = 20
    gtk-titlebar = false
    confirm-close-surface = false
    window-save-state = always
    macos-titlebar-style = hidden
    window-padding-x = 8
    window-padding-y = 8
    mouse-hide-while-typing = true
    quit-after-last-window-closed = true
    keybind = ctrl+shift+w=close_surface
    keybind = ctrl+t=new_tab
    keybind = ctrl+tab=next_tab
    keybind = ctrl+shift+n=new_window
    keybind = ctrl+shift+o=ignore
  '';
}
