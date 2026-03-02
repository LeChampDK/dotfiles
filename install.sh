#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)"

# Required dependencies
REQUIRED=(git vim gh curl)
MISSING=()

for cmd in "${REQUIRED[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
        MISSING+=("$cmd")
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo "Missing dependencies: ${MISSING[*]}"
    read -p "Install them now? (y/n): " confirm
    if [ "$confirm" = "y" ]; then
        case "$(uname -s)" in
            Linux*)
                sudo apt update && sudo apt install -y ${MISSING[*]}
                ;;
            Darwin*)
                if ! command -v brew &>/dev/null; then
                    echo "Homebrew not found. Install it first: https://brew.sh"
                    exit 1
                fi
                brew install ${MISSING[*]}
                ;;
            *)
                echo "Auto-install not supported on this OS. Install manually: ${MISSING[*]}"
                exit 1
                ;;
        esac
    else
        echo "Cannot continue without: ${MISSING[*]}"
        exit 1
    fi
fi

link_file() {
    local src="$1" dst="$2"
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
        echo "  Backed up $(basename "$dst") → $BACKUP_DIR/"
    fi
    ln -sf "$src" "$dst"
    echo "  Linked $(basename "$dst")"
}

echo "=== Dotfiles Installer ==="

# Always link shared files
echo ""
echo "Shared:"
link_file "$DOTFILES_DIR/.vimrc" "$HOME/.vimrc"

# Detect OS
OS="unknown"
case "$(uname -s)" in
    Linux*)  OS="linux";;
    Darwin*) OS="mac";;
    MINGW*|MSYS*|CYGWIN*) OS="windows";;
esac

echo ""
echo "Detected OS: $OS"
echo ""

case "$OS" in
    linux)
        echo "Linux:"
        link_file "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
        ;;
    mac)
        echo "macOS:"
        link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
        ;;
    windows)
        echo "Windows (PowerShell):"
        PS_DIR="$HOME/Documents/PowerShell"
        mkdir -p "$PS_DIR"
        link_file "$DOTFILES_DIR/windows/Microsoft.PowerShell_profile.ps1" "$PS_DIR/Microsoft.PowerShell_profile.ps1"
        ;;
    *)
        echo "Unknown OS — only .vimrc was linked."
        ;;
esac

# Link scripts directory if present
if [ -d "$DOTFILES_DIR/.scripts" ]; then
    echo ""
    echo "Scripts:"
    link_file "$DOTFILES_DIR/.scripts" "$HOME/.scripts"
fi

echo ""
echo "Done! Existing files backed up to: $BACKUP_DIR"
echo "Restart your shell or run: source ~/.bashrc / source ~/.zshrc"
