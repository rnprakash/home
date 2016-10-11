For ease of use, create a `home' alias

    alias home='git --work-tree=$HOME --git-dir=$HOME/.home'

Create a `.home' directory and initialize it

    cd
    mkdir -p .home && cd .home
    home init
    home remote add origin https://github.com/rnprakash/home.git
    home branch --set-upstream master origin/master
    home pull

Or

    home fetch --all && home reset --hard origin/master
