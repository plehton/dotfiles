# Login shell configuration
#

# Set up shell hooks
#
autoload -U add-zsh-hook

eval "$(/opt/homebrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# eval "$(pyenv virtualenv-init -)"
export PATH="/opt/homebrew/opt/pyenv-virtualenv/shims:${PATH}";
export PYENV_VIRTUALENV_INIT=1;
function -pyenv-virtualenv-hook() {
  local ret=$?
  if [ -n "${VIRTUAL_ENV-}" ]; then
    eval "$(pyenv sh-activate --quiet || pyenv sh-deactivate --quiet || true)" || true
  else
    eval "$(pyenv sh-activate --quiet || true)" || true
  fi
  return $ret
};
add-zsh-hook chpwd -pyenv-virtualenv-hook

# eval "$(direnv hook zsh)"
