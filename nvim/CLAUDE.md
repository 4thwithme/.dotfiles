# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a sophisticated Neovim configuration using a modular architecture with the `_luharsky` namespace. The configuration is organized into core settings and plugin configurations, with lazy.nvim as the plugin manager.

### Key Directories
- `init.lua` - Main entry point that loads the `_luharsky` module
- `lua/_luharsky/core/` - Core Neovim settings (options, keymaps, startup config)
- `lua/_luharsky/plugins/` - Individual plugin configurations (30+ plugins)
- `lua/_luharsky/lazy.lua` - Plugin manager configuration
- `lazy-lock.json` - Plugin version lock file (do not edit manually)

## Configuration Patterns

### Plugin Management
- Uses lazy.nvim with lazy loading enabled
- Each plugin has its own `_pluginname.lua` file in the plugins directory
- Plugin configurations follow event-based and key-based loading patterns
- Lock file maintains exact plugin versions for reproducibility

### Namespace Convention
- All custom code lives under the `_luharsky` namespace
- Core functionality separated from plugin-specific configurations
- Consistent file naming with underscore prefix for plugin files

### Key Mapping Strategy
- Leader key is Space (` `)
- Organized by functionality (navigation, git, AI, LSP)
- Uses which-key for descriptive help
- Buffer navigation via Alt + number keys
- Harpoon quick navigation via Leader + number keys

## Development Environment

### LSP Configuration
The setup includes comprehensive LSP support via nvim-lspconfig and mason.nvim:
- TypeScript/JavaScript, Lua, Python, Ruby
- Astro, GraphQL, Prisma, and more
- Auto-completion via nvim-cmp with multiple sources
- Formatting via conform.nvim, linting via nvim-lint

### AI Integration
- GitHub Copilot with CopilotChat for conversational AI
- Claude Code integration via claudecode.nvim plugin
- Extensive AI workflow key bindings

### Custom Utilities
- Visual find/replace function in `core/replace-text.lua`
- Insert mode shortcuts: `clg` → `console.log()`, `clr` → `console.error()`
- Custom startup configurations for filetype associations

## UI Features

### Theme and Appearance
- Tokyo Night colorscheme with transparency enabled
- Lualine status line with buffer management
- BufferLine for tab-like buffer navigation
- Noice.nvim for enhanced notifications and command line

### File Management
- nvim-tree and oil.nvim for file exploration
- Telescope for fuzzy finding with extensive integrations
- Harpoon for quick file bookmarking and navigation

## Working with This Configuration

### Making Changes
- Core Vim settings: Edit files in `lua/_luharsky/core/`
- Adding plugins: Create new `_pluginname.lua` in plugins directory and add to lazy setup
- Key mappings: Primarily in `core/keymap.lua`
- Startup behavior: Modify `core/onstartup.lua`

### Plugin Updates
- Use `:Lazy` command in Neovim to manage plugins
- `:Lazy update` to update all plugins
- Lock file will be updated automatically

### Custom Functions
- Text replacement utility available via visual mode selection
- Various helper functions scattered throughout plugin configurations
- Startup functions for filetype-specific behavior

## Important Notes

- Configuration is heavily customized for AI-assisted development
- Uses modern Neovim features (0.8+)
- Performance-optimized with lazy loading
- No automated setup scripts - manual configuration required