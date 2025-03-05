# Starship
eval "$(starship init zsh)"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# Node 22
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/geoffreybelcher/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/geoffreybelcher/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/geoffreybelcher/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/geoffreybelcher/google-cloud-sdk/completion.zsh.inc'; fi
