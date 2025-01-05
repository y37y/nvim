# Neovim Configuration Management

This Neovim configuration is based on chaozwn's AstroNvim setup with personal modifications. It's managed using both Git and Chezmoi for dotfile management.

## Repository Structure

* Upstream: https://github.com/chaozwn/astronvim_user (remote name: upstream)

## Workflow

### Making Changes

1. Navigate to the Neovim config directory:
   ```
   cd ~/.local/share/chezmoi/dot_config/nvim
   ```

2. Make your desired changes to the configuration files.

3. Commit and push changes to your personal repository:
   ```bash
   git add .
   git commit -m "Description of your changes"
   git push origin 
   ```

4. Update Chezmoi:
   ```
   cd ~/.local/share/chezmoi
   git add dot_config/nvim
   git commit -m "Update Neovim configuration in Chezmoi"
   git push
   ```

5. Apply the changes:
   ```
   chezmoi apply
   ```

### Pulling Updates from Upstream

1. Navigate to the Neovim config directory:
   ```
   cd ~/.local/share/chezmoi/dot_config/nvim
   ```

2. Pull updates from the upstream repository:
   ```
   git fetch upstream
   git merge upstream/astro_v4
   ```

3. If there are conflicts, resolve them manually.

4. After resolving conflicts (if any), commit and push to your personal repository:
   ```bash
   git add .
   git commit -m "Merge upstream changes"
   git push origin 
   ```

5. Update Chezmoi as described in steps 4 and 5 of "Making Changes".

### Applying Changes on a New Machine

When setting up on a new machine:

1. Clone your Chezmoi repository:
   ```
   git clone https://github.com/y37y/nvim.git ~/.config/nvim
   ```

2. Apply Chezmoi changes:
   ```
   chezmoi apply
   ```

3. Navigate to the Neovim config directory:
   ```
   cd ~/.local/share/chezmoi/dot_config/nvim
   ```

4. Set up git remotes:
   ```bash
   git remote add origin git@github.com:y37y/nvim.git
   git remote add upstream https://github.com/chaozwn/astronvim_user
   ```

5. Ensure all submodules and plugins are updated:
   ```bash
   git submodule update --init --recursive
   ```

## Remember

* Always make changes in ~/.local/share/chezmoi/dot_config/nvim, not directly in ~/.config/nvim.
* Keep your personal repository (origin), upstream, and Chezmoi all in sync by following this workflow.
* Regularly pull from upstream to stay updated with the latest changes from chaozwn's repository.
* After making changes, always run `chezmoi apply` to update your actual configuration files.

---

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

- **TypeScript**: `vtsls`.
- **Vue**: `volar2`.
- **React**: `vtsls`.
- **Angular**: `angular server`.
- **Node**: `vtsls`.
- **Python**: `basedpyright`.
- **Go**: `gopls`.
- **Rust**: `rust-analyzer`.
- **Markdown**: `markdown-preview.nvim`.

---

## 🛠️ Installation

### System Requirements

Neovim requires LuaJIT, so Lua 5.1 is currently the best version to use. [Why Neovim uses Lua 5.1](https://neovim.io/doc/user/lua.html).

#### Install Luarocks
```bash
wget https://luarocks.github.io/luarocks/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1

./configure --lua-version=5.1 --lua-suffix=5.1
make
sudo make install

luarocks --version
```

#### Install Lua 5.1
```bash
wget https://www.lua.org/ftp/lua-5.1.5.tar.gz
tar zxpf lua-5.1.5.tar.gz
cd lua-5.1.5

# For macOS
make macosx

make test
sudo make install

which lua
lua -v
```

### Required System Commands

Make sure these commands are available:
- `npm`
- `rustc`
- `go`
- `tmux`

### Recommended Tools

For macOS:
```bash
```
# Homebrew packages
brew install fzf fd lazygit ripgrep gdu bottom protobuf gnu-sed ast-grep lazydocker trash imagemagick chafa delta coreutils

For Ubuntu/Kubuntu:
```bash
# Install system packages
sudo apt-get update
sudo apt-get install fzf fd-find ripgrep bottom protobuf-compiler \
                     mercurial trash-cli imagemagick

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
```

For all platforms:
```bash
# Node.js packages
npm install -g tree-sitter-cli neovim @styled/typescript-styled-plugin

# Python packages, for render-markdown.nvim
pip install pynvim pylatexenc
```

### Installing Neovim Configuration

1. Backup existing configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   mv ~/.local/share/nvim ~/.local/share/nvim.bak
   mv ~/.local/state/nvim ~/.local/state/nvim.bak
   mv ~/.cache/nvim ~/.cache/nvim.bak
   ```

2. Follow the Chezmoi setup instructions in the previous section.

## 💡 Tips & Tricks

### NVcheatsheet

Press `<F2>` to open the NVcheatsheet.

### Use Lazygit

Trigger command: `<leader>tl`

### Use Bottom

Trigger command: `<Leader>tt`

### Neovim Requirements

Ensure Neovim dependencies are installed:
```bash
# Install Neovim dependencies
npm install -g neovim
pip install pynvim
```

### Markdown Image Paste

To enable image pasting in Markdown files, install the `pngpaste` Python package:

```bash
brew install pngpaste
```

### Show Image in Neovim

For macOS:
```bash
# Add to .zshrc and .bashrc
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"
```

For Ubuntu/Kubuntu:
```bash
# No additional configuration needed after imagemagick installation
```

### Input Method Auto Switch

For macOS users who want to automatically switch input methods:

1. Install `im-select`:
   ```bash
   brew tap laishulu/homebrew
   brew install macism
   ```

2. For Squirrel input method (optional):
   ```bash
   brew install --cask squirrel
   ```

3. Add the following configuration to your `im-select.lua` file:

   ```lua
   return {
       "chaozwn/im-select.nvim",
       lazy = false,
       opts = {
           default_command = "macism",
           default_main_select = "im.rime.inputmethod.Squirrel.Hans", -- replace with you result in step 2
           set_previous_events = { "InsertEnter", "FocusLost" },
       },
   }
   ```

### Optional Input Method

For an alternative input method, you can install `squirrel`:

```bash
brew install --cask squirrel
```

### minial start

```shell
nvim -u /Users/jayce.zhao/.config/nvim/mini_astronvim.lua .
```

---

## 🎛️ General Mappings

| Action               | Keybinding     |
|---------------------|----------------|
| Leader key          | `Space`        |
| Resize up           | `Ctrl + Up`    |
| Resize down         | `Ctrl + Down`  |
| Resize left         | `Ctrl + Left`  |
| Resize right        | `Ctrl + Right` |
| Move to upper window| `Ctrl + k`     |
| Move to lower window| `Ctrl + j`     |
| Move to left window | `Ctrl + h`     |
| Move to right window| `Ctrl + l`     |
| Force write         | `Ctrl + s`     |
| Force quit          | `Ctrl + q`     |
| New file            | `Leader + n`   |
| Close buffer        | `Leader + c`   |
| Next tab            | `]t`           |
| Previous tab        | `[t`           |
| Toggle comment      | `Leader + /`   |
| Horizontal split    | `\`            |
| Vertical split      | `\|`           |

## 📝 Notes

- Use `KK` to view and jump into signature help float window
- Quick DAP breakpoint: `<C-LeftClick>` on line number
- Requires Neovim version >= 0.10

Feel free to explore, customize, and enjoy this setup! If you have any questions or encounter issues, don't hesitate to reach out.
