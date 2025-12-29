set fish_greeting

if status is-interactive
    fastfetch
    fish_vi_key_bindings
    set --global hydro_color_pwd yellow
    set --global hydro_color_prompt yellow
    set --global hydro_color_duration green
    set --global hydro_symbol_git_dirty " ✗"
    
    # Environment variables
    set EDITOR nvim .

    # Alias definitions

    alias ll="ls -la"
    alias y="yazi"
    alias v="nvim"
    alias vim="nvim"
    alias lg="lazygit"

    # Make fish visual mode copy to clipboard instead of primary
    bind -M visual y 'fish_clipboard_copy; commandline -f end-selection'

    # Commands to run in interactive sessions can go here
end
