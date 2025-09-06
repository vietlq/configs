# Neovim Configuration

A comprehensive Neovim setup optimized for Rust, Python, and data file development on macOS with Neovim 0.11.

## Features

- **Modern LSP Integration**: Full language server support with intelligent code completion
- **Fuzzy Finding**: Powerful file and text search with Telescope
- **Git Integration**: Built-in git status, blame, and diff highlighting
- **Terminal Integration**: Floating terminal accessible within Neovim
- **Smart Editing**: Auto-completion, snippets, commenting, and auto-pairing
- **Beautiful UI**: TokyoNight theme with custom orange split borders and cursor line highlighting

## Installation

1. Ensure you have Neovim 0.11+ installed
2. Install a Nerd Font for proper icon display:
   ```bash
   brew install font-jetbrains-mono-nerd-font
   ```
3. Configure your terminal to use the Nerd Font
4. Backup your existing Neovim configuration
5. Copy `init.lua` to `~/.config/nvim/init.lua`
6. Start Neovim - plugins will install automatically via lazy.nvim

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>pv` - Toggle file explorer
- `Ctrl+\` - Toggle floating terminal

### Window Management
- `<leader>sv` - Vertical split (same file)
- `<leader>sh` - Horizontal split (same file)
- `<leader>snv` - New vertical split (blank buffer)
- `<leader>snh` - New horizontal split (blank buffer)

### File Navigation (Telescope)
- `<leader>gf` - Find files
- `<Ctrl+p>` - Git files
- `<leader>gr` - Recent files
- `<leader>gg` - Live grep
- `<leader>gs` - Grep string
- `<leader>gw` - Grep word under cursor
- `<leader>bb` - Switch buffers
- `<leader>bt` - Buffer fuzzy find

### LSP
- `gd` - Go to definition
- `K` - Hover documentation
- `<leader>vca` - Code actions
- `<leader>vrn` - Rename symbol
- `<leader>vrr` - Find references
- `<leader>lr` - LSP references
- `<leader>ld` - LSP definitions
- `<leader>ls` - Document symbols
- `<leader>lw` - Workspace symbols
- `[d` / `]d` - Navigate diagnostics
- `<leader>vd` - Open diagnostic float

### Git Integration
- `<leader>Gc` - Git commits
- `<leader>Gb` - Git branches
- `<leader>Gs` - Git status

### Editing
- `gcc` - Toggle line comment
- `gc` (visual) - Toggle comment on selection
- `<leader>ects` - Clear trailing spaces
- `<leader>f` - Format code (LSP)

### Sorting (Visual Mode)
- `<leader>so` - Sort selected lines
- `<leader>sor` - Sort selected lines (reverse)
- `<leader>son` - Sort selected lines (numeric)
- `<leader>sonr` - Sort selected lines (numeric reverse)
- `<leader>sou` - Sort selected lines (unique)
- `<leader>soi` - Sort selected lines (case-insensitive)

### Python Development
- `<leader>vs` - Select virtual environment
- `<leader>vc` - Select cached virtual environment

### Neovim Internals
- `<leader>vh` - Help tags
- `<leader>vk` - Keymaps
- `<leader>vc` - Commands
- `<leader>vr` - Registers

## Plugins

| Plugin Name | Purpose | Key Features |
|-------------|---------|--------------|
| **akinsho/toggleterm.nvim** | Terminal integration | Floating terminal with `Ctrl+\`, better in-editor terminal |
| **b0o/schemastore.nvim** | JSON schema support | Provides JSON schemas for validation and autocompletion |
| **chrisbra/csv.vim** | CSV file handling | Better CSV editing with column alignment and navigation |
| **folke/tokyonight.nvim** | Colorscheme | Dark theme with customized orange split borders |
| **folke/which-key.nvim** | Keybinding help | Shows available keybindings when you press leader key |
| **hrsh7th/cmp-buffer** | Autocompletion source | Buffer text completion for nvim-cmp |
| **hrsh7th/cmp-nvim-lsp** | Autocompletion source | LSP completion for nvim-cmp |
| **hrsh7th/cmp-nvim-lua** | Autocompletion source | Neovim Lua API completion for nvim-cmp |
| **hrsh7th/cmp-path** | Autocompletion source | File path completion for nvim-cmp |
| **hrsh7th/nvim-cmp** | Autocompletion engine | Main completion engine with smart suggestions |
| **L3MON4D3/LuaSnip** | Snippet engine | Code snippet expansion and navigation |
| **lewis6991/gitsigns.nvim** | Git integration | Git status in gutter, blame, diff highlighting |
| **linux-cultist/venv-selector.nvim** | Python virtual env | Select and switch Python virtual environments |
| **neovim/nvim-lspconfig** | LSP configuration | Language Server Protocol setup and configuration |
| **numToStr/Comment.nvim** | Code commenting | Toggle comments with `gcc`, language-aware |
| **nvim-lualine/lualine.nvim** | Status line | Shows mode, git branch, diagnostics, file info |
| **nvim-tree/nvim-tree.lua** | File explorer | Sidebar file browser, toggle with `<leader>pv` |
| **nvim-tree/nvim-web-devicons** | File icons | Provides file type icons for file explorer and status line |
| **nvim-telescope/telescope.nvim** | Fuzzy finder | Find files, search text, navigate code (many `<leader>g*` mappings) |
| **nvim-treesitter/nvim-treesitter** | Syntax highlighting | Advanced syntax highlighting and code understanding |
| **rafamadriz/friendly-snippets** | Snippet collection | Pre-built code snippets for various languages |
| **rust-lang/rust.vim** | Rust support | Rust-specific features, auto-formatting with rustfmt |
| **saadparwaiz1/cmp_luasnip** | Snippet completion | LuaSnip integration with nvim-cmp |
| **Vimjas/vim-python-pep8-indent** | Python indentation | PEP8-compliant Python indentation |
| **VonHeikemen/lsp-zero.nvim** | LSP setup helper | Simplified LSP configuration with sensible defaults |
| **williamboman/mason-lspconfig.nvim** | LSP server bridge | Connects Mason with nvim-lspconfig |
| **williamboman/mason.nvim** | LSP server manager | Install and manage language servers (rust-analyzer, pyright, etc.) |
| **windwp/nvim-autopairs** | Auto-pairing | Automatically close brackets, quotes, parentheses |

## Language Support

### Rust
- **LSP**: rust-analyzer with cargo clippy integration
- **Formatting**: Automatic rustfmt on save
- **Features**: Cargo integration, all features enabled

### Python
- **LSP**: pyright with intelligent type checking
- **Virtual Environments**: Automatic detection and switching
- **Indentation**: PEP8-compliant indentation rules
- **Type Checking**: Basic type checking enabled

### Data Files
- **JSON**: Schema validation and formatting
- **YAML**: Syntax highlighting and validation  
- **TOML**: Taplo LSP integration
- **CSV**: Column alignment and navigation tools

### Other Languages
- **Lua**: Full Neovim API completion and highlighting
- **Markdown**: Syntax highlighting and preview
- **Bash**: Syntax highlighting and basic completion

## Configuration Highlights

### Visual Enhancements
- Current line highlighting (`cursorline`)
- Orange-colored split borders for better visibility
- TokyoNight colorscheme with custom highlights
- Line numbers with relative numbering
- Color column at 80 characters
- Global statusline for better split visibility
- Unicode box-drawing characters for split borders

### Editor Behavior
- 4-space indentation for Rust and Python
- 2-space indentation for JSON, YAML, TOML
- Smart indentation and auto-formatting
- Persistent undo history
- No swap files for cleaner workspace
- 300ms timeout for key combinations

### Performance
- Fast startup with lazy.nvim plugin manager
- Treesitter for efficient syntax highlighting
- LSP with Mason for automatic language server management
- Optimized search with live grep and fuzzy finding

## Virtual Environment Integration

The configuration automatically detects Python virtual environments in these locations:
- `$VIRTUAL_ENV` environment variable
- `./venv/bin/python`
- `./.venv/bin/python`
- `./env/bin/python`
- `./.env/bin/python`

LSP servers are automatically restarted when switching between projects with different virtual environments.

## Font Requirements

This configuration uses Nerd Fonts for proper icon display. Install one of these fonts:

```bash
# Recommended fonts
brew install font-jetbrains-mono-nerd-font
brew install font-fira-code-nerd-font
brew install font-hack-nerd-font
brew install font-source-code-pro-nerd-font
```

After installation, configure your terminal application to use the Nerd Font.

## Customization

The configuration is modular and easy to customize:
- Plugin specifications are clearly separated
- Keybindings are grouped by functionality
- Language-specific settings use autocmds
- Color schemes and highlights can be easily modified
- Timeout settings can be adjusted for key combinations

## Requirements

- Neovim 0.11+
- Git (for plugin management)
- Node.js (for some LSP servers)
- Python 3.8+ (for Python development)
- Rust toolchain (for Rust development)
- Nerd Font installed and configured in terminal

## License

Feel free to use and modify this configuration for your own needs.
