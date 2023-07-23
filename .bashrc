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

# Add yarn to the PATH variable
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

_makefile_completions()
{
    if [ ! -e ./Makefile ]; then
        return
    fi

    # filter out flag arguments
    filtered_comp_words=()
    for comp_word in ${COMP_WORDS[@]}; do
        if [[ $comp_word != -* ]]; then
            filtered_comp_words+=("$comp_word")
        fi
    done

    # do nothing if a non-flag argument has already been added
    if [[ "${#filtered_comp_words[@]}" -gt 2 ]]; then
        return
    fi

    word_list="$(grep '^[^\.][-a-zA-Z\.0-9_\/]*:' ./Makefile | sed 's/:.*//g' | uniq)"
        COMPREPLY=($(compgen -W "${word_list}" "${filtered_comp_words[1]}"))
    }

complete -o nospace -F _makefile_completions make
