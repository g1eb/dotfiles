# Default editor
export EDITOR=vim

# History
HISTSIZE=1000
HISTFILESIZE=2000
HISTCONTROL=ignoreboth

# Colorize term
LS_COLORS=$LS_COLORS:'di=0;93:'; export LS_COLORS
PS1="\\[$(tput setaf 11)\\]\\u@\\h:\\w $ \\[$(tput sgr0)\\]"

# Virtualenv settings
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
vwrap=`/usr/bin/which 'virtualenvwrapper.sh'` && test -f $vwrap && source $vwrap

# Virtualenv aliases
alias v='workon'
alias v.d='deactivate'
alias v.mk='mkvirtualenv --no-site-packages'
alias v.mk_withsitepackages='mkvirtualenv'
alias v.rm='rmvirtualenv'
alias v.switch='workon'
alias v.add2virtualenv='add2virtualenv'
alias v.cdsitepackages='cdsitepackages'
alias v.cd='cdvirtualenv'
alias v.lssitepackages='lssitepackages'

# Paste files to sprunge (includes extensions)
sprunge() {
  extension=$(echo $1 | cut -f 2 -d '.')
  link=$(cat $1 | curl -s -F 'sprunge=<-' http://sprunge.us)
  echo "$link?$extension"
}
