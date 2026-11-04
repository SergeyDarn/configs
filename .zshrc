# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Nvim
export VISUAL="nvim"
export EDITOR="nvim"

vim() {
    "nvim" $1
}

gotest() {
  go test $* | sed ''/PASS/s//$(printf "\033[\e[1;32mPASS\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[\e[1;31mFAIL\033[0m")/'' | sed ''/FAIL/s//$(printf "\033[\e[1;31mFAIL\033[0m")/'' | GREP_COLOR="01;31" egrep --color=always '\s*[a-zA-Z0-9\-_.]+[:][0-9]+[:].*|^'
}
## cd to dir you're at when closing yazi + zoxide
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"

  if [ "$1" != "" ]; then
    if [ -d "$1" ]; then
      yazi "$@" --cwd-file="$tmp"
    else
      yazi --cwd-file="$tmp" "$(zoxide query $1)"
    fi
  else
    yazi "$@" --cwd-file="$tmp"
  fi

	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi

	command rm -f -- "$tmp"
}


eval "$(zoxide init zsh)"

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/oh-my-posh-catppuccin-mocha.json)"

alias ls="eza --no-filesize --long --color=always --icons=always --no-user"
alias cat="bat"
alias sz="source ~/.zshrc"
alias vz="vim ~/.zshrc"


# FZF

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias hist="history | tail -r | fzf"
alias fzfp="fzf --preview 'bat --color=always {}' --preview-window=right,60%"
alias fzfo="fzfp | xargs -n1 nvim"

alias sz="source ~/.zshrc"
alias vz="vim ~/.zshrc"

alias yt="~/yt-dlp -S "res:1080" --js-runtimes deno --cookies-from-browser chrome --socket-timeout 10 -R 0"
