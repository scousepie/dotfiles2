# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/neil/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/.zsh/functions/*

# Prompt configuration
# virtual environment prompt setup
function virtual_env_prompt () {
	REPLY=${VIRTUAL_ENV+[${VIRTUAL_ENV:t}]}
}

grml_theme_add_token virtual-env -f virtual_env_prompt '%F{001}' '%f'

zstyle ':prompt:grml:left:items:host' pre '%B%F{070}'
zstyle ':prompt:grml:left:items:path' pre '%B%F{240}'
zstyle ':prompt:grml:left:setup' items rc change-root host path newline virtual-env percent
zstyle ':prompt:grml:right:setup' items vcs

# python required lines for setting virtualenv
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/PythonProjects
#source /usr/bin/virtualenvwrapper.sh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "PS1" ] && \
	[ -s "$BASE16_SHELL/profile_helper.sh" ] && \
	eval "$("$BASE16_SHELL/profile_helper.sh")"

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles2/ --work-tree=$HOME'
alias mkvenv='python -m venv venv && cd .. && cd -'
