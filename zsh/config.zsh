export VISUAL=vim
export EDITOR=vim
bindkey -e

export ZSH_THEME_TERM_TAB_TITLE_IDLE="%100<..<%n@%m:%~%<<"
export ZSH_THEME_TERM_TITLE_IDLE="%100<..<%n@%m:%~%<<"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=23'

setopt NO_LIST_BEEP
setopt PROMPT_SUBST
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

setopt complete_aliases

export LS_COLORS="$LS_COLORS:ow=:"
export MANPAGER="less -R --use-color -Dd+r -Du+b"
#export LIBGL_ALWAYS_INDIRECT=1

