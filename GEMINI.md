# Gemini Context: Neovim Configuration (`~/.config/nvim`)

## Project Overview
This directory contains the personal Neovim configuration for user 'zaki'. It is a Lua-based configuration using **Packer** as the plugin manager. The configuration follows the standard Neovim directory structure, separating core settings, mappings, and plugin configurations.

## Key Technologies
- **Neovim (Lua):** The editor and configuration language.
- **Packer.nvim:** Plugin manager.
- **Mason:** Portable package manager for LSP servers, DAP servers, linters, and formatters.
- **LSP Config:** Native Language Server Protocol configurations.
- **Telescope:** Highly extendable fuzzy finder.
- **Treesitter:** Parsing system for better syntax highlighting and code navigation.

## Directory Structure
- `init.lua`: The entry point. Requires the `zaki` module.
- `lua/zaki/`: Core configuration modules.
    - `init.lua`: Likely imports the other modules in this folder.
    - `packer.lua`: **Crucial.** Defines and installs all plugins. Contains Mason and some LSP setup.
    - `remap.lua`: Global key mappings and custom functions (including the code runner).
    - `set.lua`: General editor options (line numbers, tab width, etc.).
- `after/plugin/`: Configuration files that run *after* the main scripts. Each file typically configures a specific plugin (e.g., `lsp.lua`, `telescope.lua`).
- `plugin/`: Automatically loaded scripts (contains `packer_compiled.lua`).

## Key Bindings (from `lua/zaki/remap.lua`)

**Leader Key:** `<Space>`

| Mode | Key | Action | Description |
| :--- | :--- | :--- | :--- |
| **General** | | | |
| n | `<leader>pv` | `:NvimTreeToggle` | Toggle File Explorer |
| n | `<leader>w` | `:w` | Save file |
| n, v | `gg` | `gg0` | Go to first line, first column |
| n, v | `G` | `G$` | Go to last line, last column |
| i | `<Esc>` | `<Esc>l` | Exit insert mode and move right |
| **Navigation** | | | |
| n | `s` | Custom | Search and jump to pattern |
| n | `<C-j>` | `<C-d>` | Scroll half-page down |
| n | `<C-k>` | `<C-u>` | Scroll half-page up |
| n | `<leader>s` | Telescope | Fuzzy find in current buffer |
| n | `<leader>pS` | Telescope | Live grep (Search project) |
| **Code Execution** | | | |
| n | `<leader>r` | Custom Function | **Run current file**. Supports: Python, C, C++, Dart, Java. |
| **LSP & Dev** | | | |
| n | `<` | `vim.lsp.buf.hover` | Hover documentation |
| n | `<leader>fa` | `vim.lsp.buf.code_action` | Code Actions |
| n | `<Esc>` | `:close` | Close floating windows (Smart Escape) |
| **Tmux** | | | |
| n | `<leader>fr` | `tmux send-keys` | Reload Tmux Window 2 (`r`) |
| n | `<leader>fhr` | `tmux send-keys` | Restart Tmux Window 2 (`R`) |

## Plugin Management (Packer)
Plugins are defined in `lua/zaki/packer.lua`.

- **Install/Update:** Open Neovim and run `:PackerSync` to install, update, and compile plugins.
- **Add Plugin:** Edit `lua/zaki/packer.lua`, add the `use '...'` line, then run `:PackerSync`.

## Language Support (LSP)
Managed via **Mason** and **nvim-lspconfig**.
- **Installed Servers (via Mason/Packer):**
    - `intelephense` (PHP)
    - `lua_ls` (Lua)
    - `clangd` (C/C++)
    - `pyright` (Python)
    - `jdtls` (Java)
- **Dart/Flutter:** handled specially via `flutter-tools.nvim`.

*Note: There is some configuration overlap between `lua/zaki/packer.lua` and `after/plugin/lsp.lua`. `packer.lua` appears to hold the primary Mason setup.*
