typeset -A __PJL
__PJL[ITALIC_ON]=$'\e[3m'
__PJL[ITALIC_OFF]=$'\e[23m'

#
# Shell settings                                                           }}}1
#

fpath=($HOME/.zsh/completions/ $fpath)
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' ${ZDOTDIR:-$HOME}/.zcompdump) ]; then
  compinit
else
  compinit -C
fi

#
# Prompt                                                                   }}}1
#

setopt PROMPT_SUBST
autoload -U colors && colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' stagedstr "%F{green}●%f" # default 'S' , ●⇡
zstyle ':vcs_info:*' unstagedstr "%F{red}●%f" # default 'U', ●✘
zstyle ':vcs_info:*' formats '[%b%m%c%u] '
zstyle ':vcs_info:git*:*' actionformats '[%b|%a] '
zstyle ':vcs_info:git+set-message:*' hooks git-untracked

function +vi-git-untracked() {
  emulate -L zsh
  if [[ -n $(git ls-files --exclude-standard --others 2> /dev/null) ]]; then
    hook_com[unstaged]+="%F{blue}●%f"
  fi
}

RPROMPT_BASE="%F{20}\${vcs_info_msg_0_}%f%F{blue}%~%f"
export RPROMPT=$RPROMPT_BASE
export PS1="%F{green}\${VENV_INFO}%f%F{blue}%1~%f%F{magenta}❯%f "


#
# History                                                                  }}}1
#

HISTFILE=~/.history
HISTSIZE=4000
SAVEHIST=$HISTSIZE


#
# Options                                                                  }}}1
#
setopt AUTO_CD                # Change dirs without cd and with ../...
setopt NO_CASE_GLOB           # Case insensitive globbing
setopt GLOB_COMPLETE          # Don't insert completion results to command line, use menu instead
setopt APPEND_HISTORY         # append history, do not owerwrite
setopt INC_APPEND_HISTORY     # adds commands as they are typed, not at shell exit
setopt EXTENDED_HISTORY       # add metadata to history
setopt SHARE_HISTORY          # share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicates first
setopt HIST_IGNORE_DUPS       # do not store duplicates
setopt HIST_FIND_NO_DUPS      # ignore duplicates when searching
setopt HIST_REDUCE_BLANKS     # removes blank lines from history
setopt HIST_VERIFY            # Don't execute command substituted from history


#
# Plugins
#


# NOTE: must come before zsh-history-substring-search & zsh-syntax-highlighting.
autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bindings                                                                 }}}1
#

if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

bindkey ' ' magic-space # do history expansion on space

#
# Source others                                                            }}}1
#

source $HOME/.zsh/aliases
source $HOME/.zsh/exports

# Third party                                                              }}}1
#

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && eval "$("$BASE16_SHELL/profile_helper.sh")"

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
. ~/.fzf.zsh

# z
. /usr/local/etc/profile.d/z.sh

# pyenv + virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(rbenv init -)"


#
# Hooks                                                                    }}}1
#

autoload -U add-zsh-hook


typeset -F SECONDS
function -record-start-time() {
  emulate -L zsh
  ZSH_START_TIME=${ZSH_START_TIME:-$SECONDS}
}
add-zsh-hook preexec -record-start-time

function -report-start-time() {
  emulate -L zsh
  if [ $ZSH_START_TIME ]; then
    local DELTA=$(($SECONDS - $ZSH_START_TIME))
    local DAYS=$((~~($DELTA / 86400)))
    local HOURS=$((~~(($DELTA - $DAYS * 86400) / 3600)))
    local MINUTES=$((~~(($DELTA - $DAYS * 86400 - $HOURS * 3600) / 60)))
    local SECS=$(($DELTA - $DAYS * 86400 - $HOURS * 3600 - $MINUTES * 60))
    local ELAPSED=''
    test "$DAYS" != '0' && ELAPSED="${DAYS}d"
    test "$HOURS" != '0' && ELAPSED="${ELAPSED}${HOURS}h"
    test "$MINUTES" != '0' && ELAPSED="${ELAPSED}${MINUTES}m"
    if [ "$ELAPSED" = '' ]; then
      SECS="$(print -f "%.2f" $SECS)s"
    elif [ "$DAYS" != '0' ]; then
      SECS=''
    else
      SECS="$((~~$SECS))s"
    fi
    ELAPSED="${ELAPSED}${SECS}"
    export RPROMPT="%F{240}%{$__PJL[ITALIC_ON]%}${ELAPSED}%{$__PJL[ITALIC_OFF]%}%f $RPROMPT_BASE"
    unset ZSH_START_TIME
  else
    export RPROMPT="$RPROMPT_BASE"
  fi
}
add-zsh-hook precmd -report-start-time

# Remember each command we run.
function -record-command() {
  __PJL[LAST_COMMAND]="$2"
}
add-zsh-hook preexec -record-command

# Update vcs_info (slow) after any command that probably changed it.
function -maybe-show-vcs-info() {
  local LAST="$__PJL[LAST_COMMAND]"

  # In case user just hit enter, overwrite LAST_COMMAND, because preexec
  # won't run and it will otherwise linger.
  __PJL[LAST_COMMAND]="<unset>"

  # Check first word; via:
  # http://tim.vanwerkhoven.org/post/2012/10/28/ZSH/Bash-string-manipulation
  case "$LAST[(w)1]" in
    cd|cp|git|rm|touch|mv)
      vcs_info
      ;;
    *)
      ;;
  esac
}
add-zsh-hook precmd -maybe-show-vcs-info

function -git-info() {
    vcs_info
}
add-zsh-hook precmd -git-info

function -venv_info() {
    if [[ -n $VIRTUAL_ENV ]]; then
        export VENV_INFO="(${VIRTUAL_ENV##*/}) "
    else
        export VENV_INFO=
    fi
}
add-zsh-hook precmd -venv_info
