# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export PATH=$PATH:~/bin

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git ruby rails brew coffee)

# User configuration

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export PATH="$HOME/Library/Haskell/bin:$PATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

source ~/.profile
eval "$(direnv hook zsh)"

#RVM Scripting

# NVM
export NVM_DIR=~/.nvm
source '/usr/local/opt/nvm/nvm.sh'

# yarn
export PATH="$PATH:`yarn global bin`"

# Custom scripts
export PATH=$PATH:~/bin

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# # ~/.extra can be used for settings you don't want to commit
for file in ~/.{bashrc,extra,bash_prompt,exports,aliases,functions}; do
        [ -r "$file" ] && source "$file"
done

# common tmux aliases
alias tns='tmux -2 new -s'
alias tas='tmux attach -t'
alias ts='tmux switch -t'
alias tls='tmux list-sessions'

# added by travis gem
[ -f /Users/user/.travis/travis.sh ] && source /Users/user/.travis/travis.sh
export PATH="/usr/local/opt/qt/bin:$PATH"

export MI_ENV=development
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/user/p/movableink/khepri/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/user/p/movableink/khepri/node_modules/tabtab/.completions/electron-forge.zsh

# lunchy
LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
  . $LUNCHY_DIR/lunchy-completion.zsh
fi
