set -U EDITOR vim
set -U VISUAL vim
set -U TERM xterm-256color
set -U fish_color_user purple
set -U fish_color_host purple
set -U fish_color_cwd brown

function home
    git --work-tree=$HOME --git-dir=$HOME/.home $argv
end
