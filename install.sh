#!/bin/zsh

stows_common=(
    bat
    fd
    finicky
    git
    homebrew
    nvim
    ssh
    tmux
    zsh
)

stows_macos=(
    ghostty
    karabiner
)

stows_wsl=()

stows_alpine=(
    bat
    fd
    git
    nvim
    ssh
    tmux
    zsh
)

# detect platform
function detect_platform {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /proc/version ]] && grep -qi microsoft /proc/version; then
        echo "wsl"
    elif [[ -f /etc/alpine-release ]]; then
        echo "alpine"
    else
        echo "linux"
    fi
}

# get stows for platform
function get_stows_for_platform {
    local platform=$(detect_platform)
    local stows=("${stows_common[@]}")

    case $platform in
        macos)
            stows+=("${stows_macos[@]}")
            ;;
        wsl)
            stows+=("${stows_wsl[@]}")
            ;;
        alpine)
            stows+=("${stows_alpine[@]}")
            ;;
    esac

    echo "${stows[@]}"
}

# stow stuff
function do_stow {
    local platform=$(detect_platform)
    local stows=($(get_stows_for_platform))

    if [[ -n "$1" ]]; then
        echo "stow $1 (platform: $platform)"
        stow --restow --adopt $1
    else
        echo "Stowing for platform: $platform"
        for s in "${stows[@]}"; do
            echo "  stow $s"
            stow --restow --adopt $s
        done
    fi
    return 0
}


# un-stow stuff
function do_unstow {
    local platform=$(detect_platform)
    local stows=($(get_stows_for_platform))

    if [[ -n "$1" ]]; then
        echo "unstow $1"
        stow --delete $1
    else
        echo "Unstowing for platform: $platform"
        for s in "${stows[@]}"; do
            echo "  unstow $s"
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


function do_apk {
    if [[ ! -f ./wsl/packages ]]; then
        echo "Error: wsl/packages not found"
        return 1
    fi
    echo "Installing Alpine packages..."
    apk add --no-cache $(cat ./wsl/packages | grep -v '^#' | xargs)
}

function do_defaults {
    if [[ "$(detect_platform)" != "macos" ]]; then
        echo "macOS defaults only supported on macOS"
        return 1
    fi
    ./macos/defaults.sh
}

function do_doctor {
    local platform=$(detect_platform)
    local errors=0

    echo "=== Dotfiles Health Check (platform: $platform) ==="
    echo ""

    # 1. Check stow symlinks
    echo -n "Checking symlinks... "
    local broken_links=$(find "$HOME" -maxdepth 3 -type l ! -exec test -e {} \; -print 2>/dev/null | wc -l)
    if [[ $broken_links -gt 0 ]]; then
        echo "FAIL ($broken_links broken)"
        find "$HOME" -maxdepth 3 -type l ! -exec test -e {} \; -print 2>/dev/null | head -5
        ((errors++))
    else
        echo "OK"
    fi

    # 2. Check required commands
    echo -n "Checking required commands... "
    local required=(git zsh tmux nvim rg fd fzf bat)
    local missing=()
    for cmd in "${required[@]}"; do
        command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
    done
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo "MISSING: ${missing[*]}"
        ((errors++))
    else
        echo "OK"
    fi

    # 3. Check platform-specific packages
    if [[ "$platform" == "macos" ]]; then
        echo -n "Checking Homebrew... "
        if command -v brew >/dev/null 2>&1; then
            echo "OK"
        else
            echo "NOT INSTALLED"
            ((errors++))
        fi
    elif [[ "$platform" == "alpine" ]]; then
        echo -n "Checking apk packages... "
        if command -v apk >/dev/null 2>&1; then
            echo "OK"
        else
            echo "NOT AVAILABLE"
            ((errors++))
        fi
    fi

    # 4. Check stow directories exist
    echo -n "Checking stow packages... "
    local stows=($(get_stows_for_platform))
    local missing_dirs=()
    for s in "${stows[@]}"; do
        [[ -d "$s" ]] || missing_dirs+=("$s")
    done
    if [[ ${#missing_dirs[@]} -gt 0 ]]; then
        echo "MISSING DIRS: ${missing_dirs[*]}"
        ((errors++))
    else
        echo "OK"
    fi

    echo ""
    echo "=== Summary ==="
    if [[ $errors -eq 0 ]]; then
        echo "All checks passed ✓"
        return 0
    else
        echo "$errors issue(s) found ✗"
        return 1
    fi
}

if [[ "$1" == "stow" ]]; then
	echo "Stowing..."
	do_stow $2
	return 0
fi;

if [[ "$1" == "unstow" ]]; then
	echo "Unstowing..."
	do_unstow $2
	return 0
fi;

if [[ $1 == "brew" ]]; then
	echo "Install homebrew bundle"
	do_homebrew
	return 0
fi

if [[ $1 == "apk" ]]; then
	echo "Install Alpine packages"
	do_apk
	return 0
fi

if [[ $1 == "defaults" ]]; then
	echo "Applying macOS defaults"
	do_defaults
	return 0
fi

if [[ $1 == "doctor" ]]; then
	do_doctor
	return 0
fi

if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]] || [[ "$1" == "help" ]]; then
	cat << 'EOF'
Dotfiles management script

USAGE:
  ./install.sh <command> [package]

COMMANDS:
  stow [package]     Symlink dotfiles for detected platform (optional: specific package)
  unstow [package]   Remove symlinks for detected platform (optional: specific package)
  brew               Install Homebrew and packages from Brewfile (macOS only)
  apk                Install Alpine packages from wsl/packages (Alpine only)
  defaults           Apply macOS defaults (macOS only)
  doctor             Check health of dotfiles installation
  --help, -h, help   Show this help message

EXAMPLES:
  ./install.sh stow              # Stow all packages for current platform
  ./install.sh stow nvim         # Stow only nvim
  ./install.sh unstow            # Remove all symlinks
  ./install.sh brew              # Install Homebrew + packages
  ./install.sh apk               # Install Alpine packages
  ./install.sh defaults          # Apply macOS defaults
  ./install.sh doctor            # Check installation health

SUPPORTED PLATFORMS:
  • macOS (with Homebrew support)
  • WSL2 (Windows Subsystem for Linux 2 with Alpine)
  • Alpine Linux
  • Generic Linux

MACHINE-SPECIFIC CONFIG:
  Create .local files for machine-specific overrides (gitignored):
    • git/.gitconfig.local         → sourced from ~/.gitconfig
    • zsh/.zsh/exports.local       → sourced from ~/.zshrc
    • ssh/.ssh/config.local        → included in ~/.ssh/config

EOF
	return 0
fi
