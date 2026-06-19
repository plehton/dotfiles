#!/bin/zsh

# macOS-only packages (not stowed on Linux)
if [[ "$(uname)" == "Darwin" ]]; then
  macos_stows=(
      finicky
      karabiner
      ghostty
      homebrew)
else
  macos_stows=()
fi

stows=(
    bat
    fd
    git
    keeb
    lazygit
    nvim
    ssh
    tmux
    zsh
    $macos_stows
)

# stow stuff
function do_stow {
    if [[ -n "$1" ]]; then
        echo "stow $1"
        stow --restow --adopt $1
    else
        for s in $stows[@]; do
            echo "stow $s"
            stow --restow --adopt $s
        done
    fi
    return 0
}



# un-stow stuff
function do_unstow {
    if [[ -n "$1" ]]; then
        echo "unstow $1"
        stow --delete $1
    else
        for s in $stows[@]; do
            echo "unstow $s"
            stow --delete $s
        done
    fi
    return 0
}



function do_homebrew {

    # install homebrew
    if [[ -d /opt/homebrew ]]
    then
        echo "Homebrew already installed. Continue with next step."
    else
        echo "Installing Homebrew."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi


    # install xcode command line tools (macOS only)
    if [[ "$(uname)" == "Darwin" ]]; then
      xcode-select -p >/dev/null
      if [[ $? ]]
      then
          echo "xcode command line tools already installed. Continue with next step."
      else
          echo "Installing xcode command line tools."
          xcode-select --install || return 0
      fi
    fi

    # install homebrew bundle
    echo "Install brew bundle"
    if [[ "$(uname)" == "Darwin" ]]; then
      brew bundle install --file=./homebrew/Brewfile || return 0
    else
      brew bundle install --no-cask --file=./homebrew/Brewfile || return 0
    fi

    # Brew installs a few jdk's, so they need to be linked to the
    # system "catalog" (macOS only)
    if [[ "$(uname)" == "Darwin" ]]; then
      echo "Linking JDK's to /Library/Java/JavaVirtualMachines"
      for f in /opt/homebrew/opt/openjdk@*/libexec/openjdk.jdk ; do
          # extract jdk version from path
          local version=${${${f/*@//}:h2}:t}
          # add symlink to system jvm dir
          local link_target=openjdk.v${version}.jdk
          echo "Linking $f to $link_target"
          sudo ln -sfn $f /Library/Java/JavaVirtualMachines/$link_target
      done
    fi
}

function do_apk {
	local -a pkgs
	pkgs=("${(f)$(grep -v '^\s*#' "${0:A:h}/alpine-packages")}")
	if (( ${#pkgs} )); then
		echo "Installing Alpine packages: $pkgs"
		sudo apk add "$pkgs[@]"
	else
		echo "No packages to install."
	fi
}

if [[ "$1" == "stow" ]]; then
	echo "Stowing..."
	do_stow $2
	exit 0
fi;

if [[ "$1" == "unstow" ]]; then
	echo "Unstowing..."
	do_unstow $2
	exit 0
fi;

if [[ $1 == "brew" ]]; then
	echo "Install homebrew bundle"
	do_homebrew
	exit 0
fi

if [[ $1 == "apk" ]]; then
	echo "Install Alpine packages"
	do_apk
	exit 0
fi
