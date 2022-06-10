export VISUAL=vim
export EDITOR=vim
bindkey -e

export ZSH_THEME_TERM_TAB_TITLE_IDLE="%100<..<%n@%m:%~%<<"
export ZSH_THEME_TERM_TITLE_IDLE="%100<..<%n@%m:%~%<<"

setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt SHARE_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

setopt complete_aliases

export LS_COLORS="$LS_COLORS:ow=:"
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
#export LIBGL_ALWAYS_INDIRECT=1

