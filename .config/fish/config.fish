set -x EDITOR vim
set -x VISUAL vim
set -x TERM xterm-256color
set -x fish_color_user purple
set -x fish_color_host purple
set -x fish_color_cwd brown

function home
    git --work-tree=$HOME --git-dir=$HOME/.home $argv
end
