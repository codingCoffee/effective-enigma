source ~/./antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle sudo
antigen bundle archlinux
antigen bundle cp
antigen bundle debian
antigen bundle docker-compose
antigen bundle docker
antigen bundle man
antigen bundle node
antigen bundle npm
antigen bundle perl
antigen bundle python
antigen bundle redis-cli
antigen bundle rsync
antigen bundle screen
antigen bundle sublime
antigen bundle supervisor
antigen bundle systemd
antigen bundle thefuck
antigen bundle vim-interaction
antigen bundle virtualenv
antigen bundle ubuntu
antigen bundle yarn
antigen bundle yum

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme robbyrussell
is-at-least $ZSH_VERSION '5.4' || antigen bundle denysdovhan/spaceship-zsh-theme

# Tell Antigen that you're done.
antigen apply

source ~/./antigen.zsh

# Added GPG key, for git
export GPG_TTY=$(tty)

# Added by Ameya Shenoy for always using commonly used flags in aria2c 
ccaria2c() {
    aria2c --summary-interval=0 --continue=true --log-level=error --max-connection-per-server=5 "$1"
}

# Activating fuck alias for thefuck module and aliasing it with k
eval $(thefuck --alias)
alias k=fuck

source ~/.profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
