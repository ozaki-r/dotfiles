if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_hisotry 100000

#set --export http_proxy $url
#set --export https_proxy $url

function bind_global_alias
    switch (commandline -t)
    case "l"
        commandline -rt '| less'
    case "h"
        commandline -rt '| head'
    case "t"
        commandline -rt '| tail'
    case "g"
        commandline -rt '| grep -i'
    case "w"
        commandline -rt '| wc -l'
    case "*"
        commandline -i '| fzf'
    end
end
bind \cg bind_global_alias

if [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]
    set SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
    export SSH_AUTH_SOCK
end

set EDITOR vim
export EDITOR

fish_add_path "$HOME/.cargo/env"

if (which zoxide >/dev/null 2>&1)
    zoxide init fish | source
end
