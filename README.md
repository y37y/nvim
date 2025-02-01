# Neovim Configuration Management

This Neovim configuration is based on chaozwn's AstroNvim setup with personal modifications. It's managed using both Git and Chezmoi for dotfile management across multiple devices (Intel Mac, Apple Silicon Mac, and Ubuntu).

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

* Always make changes in ~/.local/share/chezmoi/dot_config/nvim, not directly in ~/.config/nvim
* Keep your personal repository (origin), upstream, and Chezmoi all in sync by following this workflow
* Regularly pull from upstream to stay updated with the latest changes from chaozwn's repository
* After making changes, always run `chezmoi apply` to update your actual configuration files

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
| Nextjs     | ✅             | ✅    |

### Language Servers

- **TypeScript**: `vtsls`
- **Vue**: `volar2`
- **React**: `vtsls`
- **Angular**: `angular server`
- **Node**: `vtsls`
- **Python**: `basedpyright`
- **Go**: `gopls`
- **Rust**: `rust-analyzer`
- **Markdown**: `markdown-preview.nvim`

## Database Query

- Support full syntax hints at query time, including database tables & table columns
- Supports a modern array of backends, including NoSQL databases:
  - Big Query
  - ClickHouse
  - DuckDB
  - Impala
  - jq
  - MongoDB
  - MySQL
  - MariaDB
  - Oracle
  - PostgreSQL
  - Presto
  - Redis
  - Snowflake
  - SQL Server
  - SQLite
  - Your own easily implemented adapter

---

## 🛠️ Installation

### 1. Install Lua 5.1

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

# For macOS (Intel or Apple Silicon)
make macosx

# For Linux
# make linux

make test
sudo make install

which lua
lua -v
```

### 2. Required System Commands

Make sure these commands are available:
- `npm`
- `rustc`
- `go`
- `tmux`

### 3. Install Dependencies

Platform-specific installation commands are provided in the `setup.sh` script. Run:
```bash
chmod +x setup.sh
./setup.sh
```

The script will automatically detect your platform (Intel Mac, Apple Silicon Mac, or Ubuntu) and install the appropriate dependencies.

### 4. Additional Configuration

For macOS, add to `.zshrc` and `.bashrc`:
```bash
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"
```

For input method support, install Squirrel:
```bash
brew install --cask squirrel
```

## 🎛️ General Mappings

| Action                          | Keybinding          |
| ------------------------------- | ------------------- |
| **Leader key**                  | `Space`             |
| **Resize up**                   | `Ctrl + Up`         |
| **Resize down**                 | `Ctrl + Down`       |
| **Resize left**                 | `Ctrl + Left`       |
| **Resize right**                | `Ctrl + Right`      |
| **Move to upper window**        | `Ctrl + k`          |
| **Move to lower window**        | `Ctrl + j`          |
| **Move to left window**         | `Ctrl + h`          |
| **Move to right window**        | `Ctrl + l`          |
| **Force write**                 | `Ctrl + s`          |
| **Force quit**                  | `Ctrl + q`          |
| **New file**                    | `Leader + n`        |
| **Close buffer**                | `Leader + c`        |
| **Next tab (real Vim tab)**     | `]t`                |
| **Previous tab (real Vim tab)** | `[t`                |
| **Toggle comment**              | `Leader + /`        |
| **Horizontal split**            | `\`                 |
| **Vertical split**              | <code>&#124;</code> |

## 📝 Notes

### LSP Hover Information
- Use `KK` to view and jump into signature help float window
- Calling the function twice will jump into the floating window

### Debug Adapter Protocol (DAP)
- Quick DAP breakpoint: `<C-LeftClick>` on line number
- When working with Rust, install rust-analyzer manually:
  ```bash
  rustup component add rust-analyzer
  ```

### Minimal Start
For a lightweight configuration:
```shell
nvim -u ~/.config/nvim/mini_astronvim.lua .
```

## 🧑‍💻 Requirements

- Neovim version >= 0.10

---

Feel free to explore, customize, and enjoy this setup! If you have any questions or encounter issues, don't hesitate to reach out.
