#!/bin/bash
set -e # Exit on error

# Colors and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Print functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Check if commands exist
check_command() {
    if ! command -v "$1" &>/dev/null; then
        error "$1 is not installed. Please install it first."
    fi
}

# Backup Neovim directories
backup_neovim() {
    info "Backing up Neovim configuration..."
    local dirs=(
        "$HOME/.config/nvim"
        "$HOME/.local/share/nvim"
        "$HOME/.local/state/nvim"
        "$HOME/.cache/nvim"
    )
    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            mv "$dir" "${dir}.bak"
            info "Backed up $dir to ${dir}.bak"
        fi
    done
}

# Install Homebrew packages
install_brew_packages() {
    info "Installing Homebrew packages..."
    local packages=(
        fzf
        fd
        luarocks
        lazygit
        ripgrep
        bottom
        protobuf
        gnu-sed
        ast-grep
        neovide
        lazydocker
        gdu        # Added from upstream comment about gdu
        mercurial  # Added from upstream
    )
    for package in "${packages[@]}"; do
        if ! brew list "$package" &>/dev/null; then
            brew install "$package"
            success "Installed $package"
        else
            info "$package already installed"
        fi
    done
}

# Install Node.js packages
install_node_packages() {
    info "Installing Node.js packages..."
    local packages=(
        "tree-sitter-cli"
        "neovim"
        "@styled/typescript-styled-plugin"
    )
    for package in "${packages[@]}"; do
        npm install -g "$package"
    done
}

# Install Python packages
install_python_packages() {
    info "Installing Python packages..."
    local packages=(
        "notebook"
        "nbclassic"
        "jupyter-console"
        "pynvim"
        "pylatexenc"
        "pillow"    # Added from upstream
    )
    for package in "${packages[@]}"; do
        pip install "$package"
    done
}

# Install Rust components
install_rust_components() {
    info "Installing Rust components..."
    rustup component add rust-analyzer
}

# Main installation
main() {
    # Check for required package managers
    check_command "brew"
    check_command "npm"
    check_command "pip"
    check_command "rustup"

    # Perform backup
    backup_neovim

    # Install packages
    install_brew_packages
    install_node_packages
    install_python_packages
    install_rust_components

    success "Installation complete!"
    info "Please proceed with installing your Neovim configuration."
}

# Run main function
main
