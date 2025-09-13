# Neovim Configuration

A comprehensive Neovim setup optimized for Rust, Python, and data file development on macOS with Neovim 0.11.

## Features

- **Modern LSP Integration**: Full language server support with intelligent code completion
- **Fuzzy Finding**: Powerful file and text search with Telescope
- **Git Integration**: Built-in git status, blame, and diff highlighting with rounded borders
- **Terminal Integration**: Floating terminal accessible within Neovim
- **Smart Editing**: Auto-completion, snippets, commenting, and auto-pairing
- **Beautiful UI**: TokyoNight theme with custom orange split borders and cursor line highlighting
- **Advanced Diagnostics**: LSP Lines plugin for better error display with toggle functionality
- **Virtual Environment Display**: Shows current Python environment in status line

## Installation

1. Ensure you have Neovim 0.11+ installed
2. Install a Nerd Font for proper icon display:
   ```bash
   brew install font-jetbrains-mono-nerd-font
   ```

   You can download and install from here:
   https://www.nerdfonts.com/font-downloads

3. Configure your terminal to use the Nerd Font
4. Backup your existing Neovim configuration
5. Copy `init.lua` to `~/.config/nvim/init.lua`
6. Start Neovim - plugins will install automatically via lazy.nvim

## Key Mappings

### General
- `<Space>` - Leader key
- `<leader>pv` - Toggle file explorer
- `Ctrl+\` - Toggle floating terminal

### File Navigation (Telescope)
- `<leader>ff` - Find files
- `<Ctrl+p>` - Git files
- `<leader>fr` - Recent files
- `<leader>fg` - Live grep
- `<leader>fs` - Grep string
- `<leader>fw` - Grep word under cursor
- `<leader>bb` - Switch buffers
- `<leader>bt` - Buffer fuzzy find

### Window Management
- `<leader>sv` - Vertical split (same file)
- `<leader>sh` - Horizontal split (same file)
- `<leader>snv` - New vertical split (blank buffer)
- `<leader>snh` - New horizontal split (blank buffer)

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
- `<leader>ll` - Toggle LSP diagnostics (virtual lines ↔ off)
- `<leader>lk` - Stop pylsp LSP server

### Git Integration (Gitsigns)
- `]c` / `[c` - Navigate git hunks
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hS` - Stage buffer
- `<leader>hR` - Reset buffer
- `<leader>hp` - Preview hunk (with rounded borders)
- `<leader>hb` - Blame line (with rounded borders)
- `<leader>hd` - Diff this file
- `<leader>tb` - Toggle current line blame
- `<leader>Gc` - Git commits
- `<leader>Gb` - Git branches
- `<leader>Gs` - Git status

### Clipboard Operations
- `<leader>y` - Copy to system clipboard (visual/normal mode)
- `<leader>Y` - Copy whole line to system clipboard
- `<leader>p` - Paste from system clipboard
- `<leader>P` - Paste before cursor from system clipboard

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
| **akinsho/toggleterm.nvim** | Terminal integration | Floating terminal with `Ctrl+\`, curved borders |
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
| **lewis6991/gitsigns.nvim** | Git integration | Git status in gutter, blame, diff highlighting with rounded borders |
| **linux-cultist/venv-selector.nvim** | Python virtual env | Select and switch Python virtual environments |
| **lsp_lines.nvim** | Enhanced diagnostics | Shows LSP diagnostics as virtual lines below code |
| **neovim/nvim-lspconfig** | LSP configuration | Language Server Protocol setup and configuration |
| **numToStr/Comment.nvim** | Code commenting | Toggle comments with `gcc`, language-aware |
| **nvim-lualine/lualine.nvim** | Status line | Shows mode, git branch, diagnostics, file info, virtual environment |
| **nvim-tree/nvim-tree.lua** | File explorer | Sidebar file browser, toggle with `<leader>pv` |
| **nvim-tree/nvim-web-devicons** | File icons | Provides file type icons for file explorer and status line |
| **nvim-telescope/telescope.nvim** | Fuzzy finder | Find files, search text, navigate code (many `<leader>f*` mappings) |
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
- **LSP**: pyright with intelligent type checking (pylsp disabled by default)
- **Virtual Environments**: Automatic detection and switching with status line display
- **Indentation**: PEP8-compliant indentation rules
- **Type Checking**: Basic type checking enabled
- **Environment Display**: Current virtual environment shown in status line with 🐍 icon

### Data Files
- **JSON**: Schema validation and formatting
- **YAML**: Syntax highlighting and validation  
- **TOML**: Taplo LSP integration
- **CSV**: Column alignment and navigation tools with auto-tabularization

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
- Rounded borders for git previews and blame windows

### Advanced Diagnostics
- **lsp_lines.nvim**: Shows diagnostics as virtual lines below problematic code
- **Toggle functionality**: `<leader>ll` cycles between virtual lines and off
- **Clean by default**: No diagnostics shown at startup
- **Better readability**: Long error messages get full space instead of inline truncation

### Editor Behavior
- 4-space indentation for Rust and Python
- 2-space indentation for JSON, YAML, TOML
- Smart indentation and auto-formatting
- Persistent undo history
- No swap files for cleaner workspace
- 300ms timeout for key combinations
- Explicit clipboard operations with leader keys

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

LSP servers are automatically restarted when switching between projects with different virtual environments. The current environment is displayed in the status line with a snake icon.

## Font Requirements

This configuration uses Nerd Fonts for proper icon display. Install one of these fonts:

```bash
# Recommended fonts
brew install font-jetbrains-mono-nerd-font
brew install font-fira-code-nerd-font
brew install font-hack-nerd-font
brew install font-source-code-pro-nerd-font
```

You can download and install from here:
https://www.nerdfonts.com/font-downloads

After installation, configure your terminal application to use the Nerd Font.

## Clipboard Integration

The configuration provides explicit clipboard operations that work across all operating systems:
- Regular `y`, `p`, `d` operations stay in Neovim's internal registers
- `<leader>y`, `<leader>p` operations interact with system clipboard
- Cross-platform compatibility (macOS, Linux, Windows, WSL)

## Git Integration Features

- **Visual git hunks**: See added, modified, and deleted lines in the gutter
- **Hunk navigation**: Jump between changes with `]c` and `[c`
- **Stage/reset hunks**: Interactive git operations without leaving editor
- **Blame integration**: See git blame with `<leader>hb` in a rounded popup
- **Diff views**: Compare current file with git history
- **Rounded borders**: All git popups use rounded borders for modern appearance

## Customization

The configuration is modular and easy to customize:
- Plugin specifications are clearly separated
- Keybindings are grouped by functionality
- Language-specific settings use autocmds
- Color schemes and highlights can be easily modified
- Timeout settings can be adjusted for key combinations
- Diagnostic display can be toggled between modes

## Requirements

- Neovim 0.11+
- Git (for plugin management)
- Node.js (for some LSP servers)
- Python 3.8+ (for Python development)
- Rust toolchain (for Rust development)
- Nerd Font installed and configured in terminal

## Troubleshooting

### Multiple Python LSP Servers
If you see both pylsp and pyright running:
1. Use `<leader>lk` to stop pylsp
2. Restart Neovim to ensure only pyright loads
3. Check `:LspInfo` to verify active servers

### Missing Icons
If file icons don't display properly:
1. Ensure a Nerd Font is installed
2. Configure your terminal to use the Nerd Font
3. Restart your terminal application

### Virtual Environment Detection
If Python virtual environments aren't detected:
1. Check that your environment is activated
2. Verify the environment path matches one of the supported locations
3. Use `<leader>vs` to manually select an environment

## License

Feel free to use and modify this configuration for your own needs.
