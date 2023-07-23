# Load bash aliases
if [ -f ~/.bash_aliases ]; then
   source ~/.bash_aliases
fi

# Default editor
export EDITOR=vim

# History
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# Colorize term
LS_COLORS=$LS_COLORS:'di=0;93:'; export LS_COLORS
PS1="\\[$(tput setaf 11)\\]\\u@\\h:\\w $ \\[$(tput sgr0)\\]"

# Make sure we always use UTF-8
export LC_ALL="en_US.UTF-8"

# Paste files to vpaste
vpaste() {
  echo $(cat $1 | curl -s -F 'text=<-' http://vpaste.net)
}
