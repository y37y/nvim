# Neovim Configuration Management

This Neovim configuration is based on chaozwn's AstroNvim setup with personal modifications. It is managed via Git and intended to be cloned directly into your configuration directory.

## Repository Structure

* **Upstream:** https://github.com/chaozwn/astronvim_user (remote name: upstream)
* **Personal:** https://github.com/y37y/nvim.git (remote name: origin)

## Custom Key Mappings

### Personal Mappings
| Action | Keybinding | Description |
|--------|------------|-------------|
| **Copy to System Clipboard** | `<leader>y` | Yank selection to system clipboard |
| **Copy Line to System Clipboard** | `<leader>Y` | Yank current line to system clipboard |
| **Copy Entire Buffer** | `<leader>yy` | Copy entire file to system clipboard |
| **Select Entire Buffer** | `<leader>a` | Select all text in current buffer |
| **Vertical Diff Split** | `<leader>dv` | Create vertical split with clipboard contents for diff |
| **Exit Terminal Mode** | `<Esc>` | Exit from terminal mode to normal mode |

### Core Functionality
| Action | Keybinding | Description |
|--------|------------|-------------|
| **Search Operations** | | |
| Search Menu | `<Leader>s` | Open search menu |
| Clear Search Highlight | `<Leader>nh` | Remove search highlighting |
| Improved Forward Search | `n` | Search forward with better positioning |
| Improved Backward Search | `N` | Search backward with better positioning |
| **Line Operations** | | |
| Move Lines Up | `K` (in visual) | Move selected lines up |
| Move Lines Down | `J` (in visual) | Move selected lines down |
| **Navigation** | | |
| Start of Line | `H` | Go to first non-blank character |
| End of Line | `L` | Go to end of line |
| **Indentation** | | |
| Unindent | `<` (in visual) | Unindent selection |
| Indent | `>` (in visual) | Indent selection |
| **Terminal Integration** | | |
| Toggle Terminal | `<Leader>th` | Toggle horizontal terminal split |
| Quick Terminal Toggle | `<C-'>` | Toggle terminal with hotkey |
| **Tool Integration** | | |
| Lazygit | `<Leader>tl` | Open Lazygit interface |
| Bottom | `<Leader>tt` | Open Bottom system monitor |
| **Window Management** | | |
| Close Window | `<Leader>wc` | Close current window |
| Close Other Windows | `<Leader>wo` | Close all other windows |
| Equal Size | `<Leader>we` | Make all windows equal size |
| **LSP Features** | | |
| Restart LSP | `<Leader>lm` | Restart Language Server |
| LSP Logs | `<Leader>lg` | Show LSP logs |
| LSP Hover | `gk` | Show hover information |
| **Other** | | |
| Delete Without Copy | `x` | Delete character without copying |

## Workflow

### Making Changes

1. Navigate to the Neovim config directory:
   ```bash
   cd ~/.config/nvim

2.  Make your desired changes to the configuration files.

3.  Commit and push changes to your personal repository:

    ```bash
    git add .
    git commit -m "Description of your changes"
    git push origin main
    ```

### Pulling Updates from Upstream

1.  Navigate to the Neovim config directory:

    ```bash
    cd ~/.config/nvim
    ```

2.  Pull updates from the upstream repository:

    ```bash
    git fetch upstream
    git merge upstream/astro_v4
    ```

3.  If there are conflicts, resolve them manually.

4.  Push the merged updates to your personal repository:

    ```bash
    git push origin main
    ```

### Applying Changes on a New Machine

When setting up on a new machine:

1.  **Clone the repository directly:**

    ```bash
    git clone [https://github.com/y37y/nvim.git](https://github.com/y37y/nvim.git) ~/.config/nvim
    ```

2.  **Navigate to the directory:**

    ```bash
    cd ~/.config/nvim
    ```

3.  **Set up git remotes:**

    ```bash
    # (Origin is already set by clone)
    git remote add upstream [https://github.com/chaozwn/astronvim_user](https://github.com/chaozwn/astronvim_user)
    ```

4.  **Run the setup script:**

    ```bash
    chmod +x setup.sh
    ./setup.sh
    ```

-----

# 🚀 AstroNvimV5 Configuration

Welcome to my customized AstroNvimV5 configuration\! This setup has been optimized for an efficient and powerful development workflow.

-----

## 🔧 Features

This configuration supports development in the following languages:

| Language   | AutoCompletion | Debug |
| ---------- | -------------- | ----- |
| Typescript | ✅             | ✅    |
| Vue        | ✅             | ✅    |
| React      | ✅             | ✅    |
| Solid      | ✅             | ✅    |
| Angular    | ✅             | ✅    |
| Node       | ✅             | ✅    |
| Python     | ✅             | ✅    |
| Rust       | ✅             | ✅    |
| Go         | ✅             | ✅    |
| Nextjs     | ✅             | ✅    |

  - **TypeScript**: `vtsls`.
  - **Vue**: `volar2`.
  - **React**: `vtsls`.
  - **Angular**: `angular server`.
  - **Node**: `vtsls`.
  - **Python**: `basedpyright`.
  - **Go**: `gopls`.
  - **Rust**: `rust-analyzer`.
  - **Markdown**: `markdown-preview.nvim`.

## Database Query

  - Support full syntax hints at query time.
  - Supports NoSQL and SQL backends (Big Query, ClickHouse, DuckDB, MongoDB, MySQL, PostgreSQL, Redis, SQLite, etc).

-----

## 🛠️ Installation

### 1\. Automated Installation (Recommended)

Simply run the included setup script. It handles Lua, Node, Python, and Homebrew dependencies automatically.

```bash
chmod +x setup.sh
./setup.sh
```

### 2\. Manual Installation Steps

If you prefer to install manually, follow these steps:

#### Install Lua 5.1 (via Homebrew)

While Neovim uses its own internal LuaJIT, installing Lua 5.1 via Homebrew ensures compatibility for external tools and `luarocks` dependencies:

```bash
brew install lua@5.1 luarocks
brew link --force lua@5.1
```

#### Install System Dependencies

```bash
# Homebrew packages
brew install fzf fd lazygit ripgrep gdu bottom protobuf gnu-sed ast-grep lazydocker trash imagemagick chafa delta coreutils pipx

# Node.js packages
npm install -g tree-sitter-cli neovim @styled/typescript-styled-plugin @monodon/typescript-nx-imports-plugin

# Python packages (using pip3/pipx)
pip3 install --user pynvim pylatexenc
```

#### Install AstroNvim

Backup your existing Neovim configuration and clone this repo:

```bash
mv ~/.config/nvim ~/.config/nvim.bak
rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

# Clone configuration
git clone [https://github.com/y37y/nvim.git](https://github.com/y37y/nvim.git) ~/.config/nvim
```

-----

## 🖥️ Workflow Screenshots

### Kitty + tmux + AstroNvim

### tmux

-----

## 🦀 Rust Development Note

When working with Rust, note that `rustup` and `mason` install `rust-analyzer` differently. Manual installation is recommended:

```bash
rustup component add rust-analyzer
```

-----

## 💡 Tips & Tricks

### Use Lazygit

Trigger command: `<leader>tl`

### Install Bottom

Trigger command: `<Leader>tt`

```bash
brew install bottom
```

### Markdown Image Paste

To enable image pasting in Markdown files:

```bash
brew install pngpaste
```

### Input Method Auto Switch (macOS)

To automatically switch input methods (e.g., English in Normal mode) on macOS:

```bash
brew tap daipeihust/tap
brew install im-select
```

-----

## 🎛️ General Mappings

| Action                          | Keybinding          |
| ------------------------------- | ------------------- |
| **Leader key** | `Space`             |
| **Resize up** | `Ctrl + Up`         |
| **Resize down** | `Ctrl + Down`       |
| **Resize left** | `Ctrl + Left`       |
| **Resize right** | `Ctrl + Right`      |
| **Move to upper window** | `Ctrl + k`          |
| **Move to lower window** | `Ctrl + j`          |
| **Move to left window** | `Ctrl + h`          |
| **Move to right window** | `Ctrl + l`          |
| **Force write** | `Ctrl + s`          |
| **Force quit** | `Ctrl + q`          |
| **New file** | `Leader + n`        |
| **Close buffer** | `Leader + c`        |
| **Next tab** | `]t`                |
| **Previous tab** | `[t`                |
| **Toggle comment** | `Leader + /`        |
| **Horizontal split** | `\`                 |
| **Vertical split** | \<code\>|\</code\> |

-----

## 🧑‍💻 Supported Neovim Version

This configuration supports Neovim version `>= 0.10`.

Happy coding\! 🚀

