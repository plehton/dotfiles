#!/bin/zsh

stows=(
    homebrew
    nvim
    zsh
)

# stow stuff
function do_stow {
    for s in $stows[@]; do
        echo stow $s
        stow --restow --adopt $s
    done
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


    # install xcode command line tools
    xcode-select -p >/dev/null
    if [[ $? ]]
    then
        echo "xcode command line tools already installed. Continue with next step."
    else
        echo "Installing xcode command line tools."
        xcode-select --install || return 0
    fi

    # install homebrew bundle
    echo "Install brew bundle"
    brew bundle install --file=./homebrew/Brewfile || return 0

    # Brew installs a few jdk's, so they need to be linked to the
    # system "catalog"
    echo "Linking JDK's to /Library/Java/JavaVirtualMachines"
    for f in /opt/homebrew/opt/openjdk@*/libexec/openjdk.jdk ; do
        # extract jdk version from path
        local version=${${${f/*@//}:h2}:t}
        # add symlink to system jvm dir
        local link_target=openjdk.v${version}.jdk
        echo "Linking $f to $link_target"
        sudo ln -sfn $f /Library/Java/JavaVirtualMachines/$link_target
    done
}

echo "Stow configs"
do_stow

echo "Install homebrew bundle"
do_homebrew
