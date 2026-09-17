# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#pyenv setup
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# export PATH="$PYENV_ROOT/shims:$PATH"

# export PYENV_DISABLE_AUTO_REHASH=1

# eval "$(pyenv init --path)"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/keys/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/Downloads/powerlevel10k/powerlevel10k.zsh-theme

# misc keybindings
# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word

bindkey '^[[1;5D' backward-word

# spark setup
SPARK_HOME=/opt/spark/spark-4.0.0-bin-hadoop3
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/bin

# zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

# doom emacs
export PATH="$HOME/.config/emacs/bin:$PATH"

# ls/exa alias
# alias ls="exa -lh --group-directories-first --sort=modified --time=created --icons"

# power controls (may require password via sudo depending on your setup)
alias shutdown='systemctl poweroff'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias restart='systemctl reboot'

# switching gaps on and off
alias swapgaps='~/.config/hypr/scripts/renamescript.sh'

# sleep: use function so it works even if you pass args by accident
sleep() {
  # if you wanted to keep normal sleep behavior sometimes, rename this command (see note below)
  systemctl suspend
}

alias ankeys="vim /home/keys/.var/app/net.ankiweb.Anki/data/Anki2/addons21/24411424/config.json"
alias mpvkeys="vim .config/mpv/input.conf"
alias mpvconf="vim .config/mpv/mpv.conf"
export SPOTIPY_CLIENT_ID="bf9e0cf0a7d64aff85f272075be7b5fb"
export SPOTIPY_CLIENT_SECRET="3121ac5cb3274ddda37ba84c6e2e2edc"

# Japanese audio downloader
dl() {
  python3 /home/keys/me_meow/code/japanese_immersion_scripts/audio_dl.py "$1"
}

