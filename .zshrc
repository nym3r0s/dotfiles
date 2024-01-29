# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

#############################################################################3
# Gokul's custom ZSH config
#############################################################################3

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH=$HOME/bin:/usr/local/bin:$PATH

export HOMEBREW_NO_AUTO_UPDATE=1
export GLOVO_NPM_TOKEN=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

# PATH additions
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/Users/gokul/hackspace/clickhouse:$PATH"

# PyEnv
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

source <(kubectl completion zsh)
alias k="kubectl"
alias kns="kubens"
alias kctx="kubectx"
alias acd="argocd"

# Terraform version to tfswitch
export TF_VERSION=1.0.11

# GPG
export GPG_TTY=$(tty)

# GOLANG
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# SRCGRPH
export SRC_ENDPOINT=https://glovo.sourcegraph.com
export SRC_ACCESS_TOKEN=sgp_4359bb6047c0d143_55983d5a57916c5167001f7b8993528eb8142059

# FZF 
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# POSTGRESQL utils
export PATH="$HOMEBREW_PREFIX/opt/postgresql@15/bin:$PATH"

#MySQL client
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Krew K8S
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

#JIRA_CLI
export JIRA_API_TOKEN=ATATT3xFfGF0OYmnO3CO_jvCGhVzNh-rDgkREiUVe5MNtWZ36LBqnhqrDkfNlyAUKsOkkOE9WZmtiHck3vJLMBbV6qmvMLt21O-zdABGgyTLD7TVEzuYb3lNMP6iZua8-r7eINoIgrhd2gHa6pSaY3repe7NyyNkhHcy0bydD9botiN9lONLxWE=9C028D1E

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"