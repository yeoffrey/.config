# Starship
eval "$(starship init zsh)"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Zoxide (better cd)
eval "$(zoxide init zsh)" 

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias cd="z"
alias ls="eza --icons=always"
alias v="nvim"
alias t="tmux kill-server 2>/dev/null; tmux new-session -c ~/tailwind"
alias e="exit"
alias c="clear"

# History
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd="z"

# Eza (better ls)
alias ls="eza --icons=always"

alias v="nvim"
alias t="tmux --kill-server; tmux"

# Node 22
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/geoffreybelcher/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/geoffreybelcher/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/geoffreybelcher/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/geoffreybelcher/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/.local/bin:$PATH"
