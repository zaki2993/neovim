# Repository Guidelines

## Project Structure & Module Organization
The entrypoint `init.lua` loads the `lua/zaki` modules that hold reusable configuration; keep shared logic in `lua/zaki/*.lua` and import it with `require('zaki.<module>')`. Place plugin-specific tweaks under `after/plugin/` (for example, Telescope mappings in `after/plugin/telescope.lua`) so they load only when the plugin is available. Generated artifacts such as `plugin/packer_compiled.lua` should never be hand-edited—regenerate them through Packer after plugin changes.

## Build, Test, and Development Commands
Launch Neovim with this profile via `nvim -u ~/.config/nvim/init.lua` to verify changes in a clean session. Sync and compile plugins by running `:PackerSync` (installs/updates) and `:PackerCompile` (refreshes the compiled loader); a headless batch run is `nvim --headless -u init.lua +"PackerSync" +qa`. Use `:checkhealth` (and plugin-specific subcommands like `:checkhealth telescope`) to confirm external dependencies are satisfied.

## Coding Style & Naming Conventions
Lua files should use two-space indentation and include a trailing newline. Default to single quotes for Lua strings, reserving double quotes for embedded quotes or Neovim commands. Name files with snake_case (`remap.lua`, `packer.lua`) and expose modules as `zaki.<name>` to keep `require` paths consistent. When declaring keymaps, prefer `vim.keymap.set` with `<leader>`-based combinations and provide optional tables for clarity (`vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Project files' })`).

## Testing Guidelines
Run `nvim --headless -u init.lua +"lua require('zaki')" +qa` after structural edits to catch syntax errors early. For individual plugin configs, execute `:luafile %` inside Neovim and inspect `:messages` for warnings. Whenever you adjust Tree-sitter languages in `after/plugin/treesitter.lua`, validate parsers with `:TSUpdate` and confirm heavy files still open without errors.

## Commit & Pull Request Guidelines
The existing history favours short, imperative subjects (`Upload all configs`, `Add all .conf files`); keep new commits under ~50 characters and focused on a single concern. Describe notable details (new keymaps, plugin additions, dependency requirements) in the commit body or pull request. PRs should reference related issues, list the verification commands you ran, and include screenshots or asciicasts when UI or keybinding behaviour changes.

## Security & Configuration Tips
Avoid committing machine-specific secrets or cache files—limit tracked changes to reproducible configuration. Note any external prerequisites (like the Tree-sitter CLI or ripgrep for Telescope) in the PR description so other contributors can prepare their environment.
