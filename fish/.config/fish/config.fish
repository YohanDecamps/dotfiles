set fish_greeting
set -x EDITOR nvim
alias vi="nvim"
alias vim="nvim"

if status is-interactive
    fastfetch
    fish_vi_key_bindings

    if test -z "$WAYLAND_DISPLAY"
        uwsm start hyprland.desktop
    end

    set --global hydro_color_pwd yellow

    set --global hydro_color_prompt yellow
    set --global hydro_color_duration green
    set --global hydro_symbol_git_dirty " ✗"
    
    # Environment variables

    set -x WLR_RENDERER nvidia-drm
    set -x WLR_NO_HARDWARE_CURSORS 1
    set -x __NV_PRIME_RENDER_OFFLOAD 1
    set -x __GLX_VENDOR_LIBRARY_NAME nvidia
    set -x MANPAGER "nvim +Man!"

    # Add rust binaries to PATH
    set -x PATH $HOME/.cargo/bin $PATH

    # Alias definitions
    alias ll="ls -la"
    alias v="nvim"
    alias vim="nvim"
    alias lg="lazygit"
    alias ymp4="yt-dlp -f \"bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]\""

    # Functions

    # Spleeter
    function spleeter
        set filename $argv[1]
        set basename (string replace -r '\.[^.]+$' '' $filename)
        set outdir (pwd)/"$basename"
    
        mkdir -p "$outdir"
        cp (pwd)/"$filename" "$outdir"/"$filename"
    
        docker run \
            -v "$outdir":/output \
            -v (pwd)/"$filename":/"$filename" \
            deezer/spleeter:3.6-5stems separate --verbose -o /output /"$filename"
    
        # fix permissions on files written by docker as root
        sudo chown -R $USER:$USER "$outdir"
    
        # flatten the extra subdirectory spleeter creates
        set subdir "$outdir"/"$basename"
        if test -d "$subdir"
            mv "$subdir"/* "$outdir"/
            rm -rf "$subdir"
        end
    end

    # keybindings
    bind -M insert alt-f 'y'
    bind alt-f 'y'

    # Make fish visual mode copy to clipboard instead of primary
    bind -M visual y 'fish_clipboard_copy; commandline -f end-selection'

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end   # Commands to run in interactive sessions can go here
end
