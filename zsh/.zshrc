# Interactive shell config (after .zprofile)

# Initial settings                                                          {{{1

# per function profiling

# zmodload zsh/zprof
# zmodload zsh/datetime
# PS4='+$EPOCHREALTIME %N:%i> '
# exec 3>&2 2>/tmp/zshstart.out
# setopt xtrace prompt_subst


# Set global variable(s)                                                    {{{1
#
fpath=($HOME/.zsh/functions/ $HOME/.zsh/completions/ /opt/homebrew/completions/zsh/ /opt/homebrew/share/zsh/site-functions $fpath)

# Funtions, aliases                                                         {{{1
#

source $HOME/.zsh/aliases
source $HOME/.zsh/exports
autoload -Uz $HOME/.zsh/functions/*(:t)
autoload -Uz vcs_info

# Prompt                                                                    {{{1
#
. $HOME/.zsh/prompt

# History                                                                   {{{1
#

HISTFILE=~/.history
HISTSIZE=4000
SAVEHIST=$HISTSIZE

#
# Options                                                                   {{{1
#
setopt EMACS                    # Command line editing in EMACS mode
setopt AUTO_CD                  # Change dirs without cd and with ../...
setopt NO_CASE_GLOB             # Case insensitive globbing
setopt GLOB_COMPLETE            # Don't insert completion results to command line, use menu instead
setopt APPEND_HISTORY           # append history, do not owerwrite
setopt INC_APPEND_HISTORY       # adds commands as they are typed, not at shell exit
setopt EXTENDED_HISTORY         # add metadata to history
setopt SHARE_HISTORY            # share history between sessions
setopt HIST_IGNORE_DUPS         # do not store duplicates
setopt HIST_IGNORE_SPACE        # do not store commands starting with space
setopt HIST_FIND_NO_DUPS        # ignore duplicates when searching
setopt HIST_EXPIRE_DUPS_FIRST   # expire duplicates first
setopt HIST_REDUCE_BLANKS       # removes blank lines from history
setopt HIST_VERIFY              # Don't execute command substituted from history
setopt HIST_IGNORE_SPACE        # Don't save commands starting with space char


# Plugins                                                                   {{{1
#


# NOTE: must come before zsh-history-substring-search & zsh-syntax-highlighting.
autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh


# Bindings                                                                  {{{1
#

if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

bindkey ' ' magic-space # do history expansion on space

#
# Init completion system                                                    {{{1
#
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24) ; do
  compinit
done
compinit -C

#
# Third party settings                                                      {{{1
#

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --follow --hidden --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
source <(fzf --zsh)

# z
. /opt/homebrew/etc/profile.d/z.sh

# profiling output
# zprof > /tmp/zshprof.out
# unsetopt xtrace
# exec 2>&3 3>&-

-show-vcs-info-in-git-dir

# vim: ft=zsh foldmethod=marker foldmarker={{{,}}}
