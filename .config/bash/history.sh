# control history
shopt -s histappend
HISTFILESIZE=
HISTSIZE=-1
HISTCONTROL=ignoreboth
PROMPT_COMMAND="history -a;history -r;$PROMPT_COMMAND"
