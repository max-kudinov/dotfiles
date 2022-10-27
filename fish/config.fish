if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
fish_vi_key_bindings

# Keybind to complete whole autosuggestion
bind -M insert \cf accept-autosuggestion

# Keybind to complete next word from autosuggestion
bind -M insert \cd forward-word

# Keybind to complete next char from autosuggestion
bind -M insert \cs forward-single-char 
