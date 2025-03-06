eval "$(/opt/homebrew/bin/brew shellenv)"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:$HOME/.config/scripts:$PATH

# export TOOLCHAINS=$(plutil -extract CFBundleIdentifier raw /Library/Developer/Toolchains/swift-6.1-DEVELOPMENT-SNAPSHOT-2025-02-21-a.xctoolchain/Info.plist)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh
export EDITOR='vim'
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Check if the shell is interactive
if [[ $- == *i* ]]; then
  alias n="nvim"
  alias lg="lazygit"
  alias ll="ls -alF"
  alias ls="eza --icons=always" # better ls
  alias cd="z" # better cd
  alias gst="git status"
  alias gcm="git commit -m"
  alias gcz="git cz commit"
  alias gaa="git add --all"
  alias ga="git add"
  alias gp="git push"
  alias gpf="git push --force"
  alias gpl="git pull"
  alias gsm="git switch main"
  alias gsmp="git switch main && git pull"
  alias gcb="git checkout -b"
  alias wmm="aerospace config --get mode.main.binding --json | less"
  alias wmr="aerospace config --get mode.resize.binding --json | less"
  alias ttt="tt -notheme -n 30 -showwpm -blockcursor -noskip -highlight2"

fi

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=9999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ZSH Plugins
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)" # better cd

wallpaper () { automator -i "${1}" ~/.config/automator/setDesktopPix.workflow }
