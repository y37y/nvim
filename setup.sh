#!/bin/bash
set -e # Exit on error

# Colors and formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Print functions
info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ -f /etc/os-release ]]; then
        source /etc/os-release
        echo "${ID,,}" # Convert to lowercase
    else
        error "Unsupported operating system"
    fi
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
    local backup_suffix=$(date +%Y%m%d_%H%M%S)
    local dirs=(
        "$HOME/.config/nvim"
        "$HOME/.local/share/nvim"
        "$HOME/.local/state/nvim"
        "$HOME/.cache/nvim"
    )
    for dir in "${dirs[@]}"; do
        if [ -d "$dir" ]; then
            mv "$dir" "${dir}.bak.${backup_suffix}"
            info "Backed up $dir to ${dir}.bak.${backup_suffix}"
        fi
    done
}

# Install Lua 5.1
install_lua() {
    info "Installing Lua 5.1..."
    local os_type=$(detect_os)
    
    if [[ "$os_type" == "macos" ]]; then
        # macOS installation
        brew install lua@5.1
        
        # Install LuaRocks for Lua 5.1
        wget https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
        tar zxpf luarocks-3.11.1.tar.gz
        cd luarocks-3.11.1
        ./configure --lua-version=5.1 --lua-suffix=5.1
        make
        sudo make install
        cd ..
        rm -rf luarocks-3.11.1*
        
    elif [[ "$os_type" == "ubuntu" ]] || [[ "$os_type" == "kali" ]]; then
        # Ubuntu/Kali installation
        sudo apt-get update
        sudo apt-get install -y lua5.1 liblua5.1-0-dev luarocks
    else
        error "Unsupported operating system for Lua installation"
    fi
    
    # Verify installation
    if command -v lua5.1 &>/dev/null; then
        success "Lua 5.1 installed successfully: $(lua5.1 -v)"
    else
        error "Lua 5.1 installation failed"
    fi
}

# Setup fnm (Fast Node Manager)
setup_fnm() {
    info "Setting up fnm (Fast Node Manager)..."
    local os_type=$(detect_os)
    
    if ! command -v fnm &>/dev/null; then
        if [[ "$os_type" == "macos" ]]; then
            brew install fnm
        else
            curl -fsSL https://fnm.vercel.app/install | bash
            # Add fnm to shell
            export PATH="/home/$USER/.local/share/fnm:$PATH"
        fi
        
        # Add fnm to shell configuration
        local shell_rc="$HOME/.zshrc"
        if [[ "$SHELL" == */bash ]]; then
            shell_rc="$HOME/.bashrc"
        fi
        
        if ! grep -q "fnm env" "$shell_rc"; then
            echo 'eval "$(fnm env --use-on-cd)"' >> "$shell_rc"
            success "Added fnm to $shell_rc"
        fi
    fi
    
    # Load fnm
    eval "$(fnm env)"
    
    # Install and use LTS Node.js
    fnm install --lts
    fnm use lts-latest
    
    success "fnm setup complete. Node version: $(node -v)"
}

# Install packages based on OS
install_packages() {
    local os_type=$(detect_os)
    
    if [[ "$os_type" == "macos" ]]; then
        install_brew_packages
    elif [[ "$os_type" == "ubuntu" ]] || [[ "$os_type" == "kali" ]]; then
        install_apt_packages
    else
        error "Unsupported operating system for package installation"
    fi
}

# Install Homebrew packages (macOS)
install_brew_packages() {
    info "Installing Homebrew packages..."
    local packages=(
        fzf
        fd
        lazygit
        ripgrep
        gdu
        bottom
        protobuf
        gnu-sed
        ast-grep
        neovide
        lazydocker
        delta
        coreutils
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

# Install APT packages (Ubuntu/Kali)
install_apt_packages() {
    info "Installing APT packages..."
    sudo apt-get update
    sudo apt-get install -y \
        fzf \
        fd-find \
        ripgrep \
        python3-full \
        python3-pip \
        python3-venv \
        protobuf-compiler

    # Install packages that might need external repositories
    install_external_apt_packages
}

# Install packages from external repositories
install_external_apt_packages() {
    # Install Lazygit
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm lazygit.tar.gz lazygit
}

# Install Node.js packages
install_node_packages() {
    info "Installing Node.js packages..."
    # Ensure fnm and node are available
    if ! command -v fnm &>/dev/null; then
        error "fnm not found. Please install fnm first."
    fi
    
    # Make sure we're using the right Node version
    eval "$(fnm env)"
    
    local packages=(
        "tree-sitter-cli"
        "neovim"
        "@styled/typescript-styled-plugin"
        "@monodon/typescript-nx-imports-plugin"
    )
    
    for package in "${packages[@]}"; do
        npm install -g "$package"
    done
    
    success "Node.js packages installed successfully"
}

# Setup Python environment
setup_python() {
    info "Setting up Python environment..."
    # Create virtual environment
    if [ ! -d "$HOME/.neovim-venv" ]; then
        python3 -m venv "$HOME/.neovim-venv"
    fi
    
    # Activate and install packages
    source "$HOME/.neovim-venv/bin/activate"
    pip install \
        notebook \
        nbclassic \
        jupyter-console \
        pynvim \
        pylatexenc \
        pillow
    deactivate
    
    success "Python environment setup complete"
}

# Install Rust components
install_rust_components() {
    info "Installing Rust components..."
    rustup component add rust-analyzer
}

# Setup Neovim configuration
setup_neovim_config() {
    info "Setting up Neovim configuration..."
    
    # Clone configuration
    if [ ! -d ~/.config/nvim ]; then
        git clone --recursive https://github.com/y37y/nvim.git ~/.config/nvim
        cd ~/.config/nvim
        
        # Set up upstream remote
        git remote add upstream https://github.com/chaozwn/astronvim_user
        git fetch upstream
        
        # Initialize and update submodules
        git submodule update --init --recursive --force
        git submodule foreach git pull origin master
    else
        warning "Neovim configuration directory already exists"
    fi
}

# Main installation
main() {
    local os_type=$(detect_os)
    info "Detected OS: $os_type"
    
    # Check for required package managers
    if [[ "$os_type" == "macos" ]]; then
        check_command "brew"
    fi
    check_command "pip"
    check_command "rustup"
    
    # Install Lua 5.1
    install_lua
    
    # Setup fnm and Node.js
    setup_fnm
    
    # Backup existing Neovim configuration
    backup_neovim
    
    # Install OS-specific packages
    install_packages
    
    # Install language-specific packages
    install_node_packages
    setup_python
    install_rust_components
    
    # Setup Neovim configuration
    setup_neovim_config
    
    success "Installation complete!"
    warning "Please run :checkhealth in Neovim to verify the installation"
    warning "If you need custom fonts, make sure to install Nerd Fonts"
}

# Run main function
main
