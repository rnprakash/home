For ease of use, create a `home` alias

    alias home='git --work-tree=$HOME --git-dir=$HOME/.home'

Create a `.home` directory and initialize it

    mkdir -p ~/.home && cd ~/.home
    home init
    home remote add origin https://github.com/rnprakash/home.git
    home fetch --all origin master && home reset --hard origin/master
    home branch --set-upstream-to origin/master

