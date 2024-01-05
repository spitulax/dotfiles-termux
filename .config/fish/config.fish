## ENVIRONMENT VARIABLES
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $fish_user_paths 
set -x TERM xterm-256color
set -x EDITOR nvim
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CACHE_HOME $HOME/.cache
set -x TEMPDIR $HOME/.temp
set -x ROOT /data/data/com.termux/files
set -x STORAGE /storage/emulated/0
set -x USR $ROOT/usr
set -x BIN $ROOT/usr/bin
set -x ETC $ROOT/usr/etc

## VI MODE
function fish_user_key_bindings
  fish_vi_key_bindings
end

## !! AND !$ COMMANDS
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end
function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

### FUNCTIONS ###

# The Music Fleet
function mf --argument ytmlink spotlink
    spotdl download "$ytmlink|$spotlink"
end

### END OF FUNCTIONS ###

## ALIASES
# eza
alias ls="eza -G -laH --no-user --color=always --group-directories-first --icons";
alias lr="eza -G --no-user --color=always --group-directories-first --icons";
alias la="eza -G -a --no-user --color=always --group-directories-first --icons";
alias ll="eza -G -lH --no-user --color=always --group-directories-first --icons";
alias lt="eza -G -Ta --no-user --color=always --group-directories-first --icons --long -L";
# shortcuts
alias vim="nvim";
alias ".."="cd ..";
alias "..."="cd ../..";
alias q="exit";
# colorizer
alias grep="grep --color";
alias egrep="egrep --color";
alias fgrep="fgrep --color";
alias hexedit="hexedit --color";

if status is-interactive
  # Remove fish intro message
  set fish_greeting

  # Starship prompt
  starship init fish | source
  
  # Vi mode cursor indicator
  function fish_mode_prompt
    switch $fish_bind_mode
      case default
        echo -en "\e[2 q"
      case insert
        echo -en "\e[6 q"
      case replace_one
        echo -en "\e[4 q"
      case visual
        echo -en "\e[6 q"
      case '*'
        echo -en "\e[2 q"
    end
    set_color normal
  end
end
