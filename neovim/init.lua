-- ~/.config/nvim/init.lua
-- Neovim configuration for Rust, Python, and data file development

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true  -- Add this line to highlight the current line
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.fillchars = { horiz = '─', horizup = '┴', horizdown = '┬', vert = '│', vertleft = '┤', vertright = '├', verthoriz = '┼' }
vim.opt.laststatus = 3  -- Global statusline to better show horizontal splits

-- Leader key
vim.g.mapleader = " "

-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
local plugins = {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
      -- Customize split borders to orange
      vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#ff9500" })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = "#ff9500" })
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "target/",
            "*.pyc",
            "__pycache__/",
          },
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            }
          }
        }
      }

      local builtin = require('telescope.builtin')

      -- File finding
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })

      -- Text searching
      vim.keymap.set('n', '<leader>fs', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ") })
      end, { desc = "Grep string" })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = "Grep word under cursor" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })

      -- LSP integration
      vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "LSP references" })
      vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = "LSP definitions" })
      vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set('n', '<leader>lw', builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

      -- Git integration
      vim.keymap.set('n', '<leader>Gc', builtin.git_commits, { desc = "Git commits" })
      vim.keymap.set('n', '<leader>Gb', builtin.git_branches, { desc = "Git branches" })
      vim.keymap.set('n', '<leader>Gs', builtin.git_status, { desc = "Git status" })

      -- Neovim internals
      vim.keymap.set('n', '<leader>vh', builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set('n', '<leader>vk', builtin.keymaps, { desc = "Keymaps" })
      vim.keymap.set('n', '<leader>vc', builtin.commands, { desc = "Commands" })
      vim.keymap.set('n', '<leader>vr', builtin.registers, { desc = "Registers" })

      -- Buffers and tabs
      vim.keymap.set('n', '<leader>bb', builtin.buffers, { desc = "Buffers" })
      vim.keymap.set('n', '<leader>bt', builtin.current_buffer_fuzzy_find, { desc = "Buffer fuzzy find" })
    end
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "rust", "python", "lua", "vim", "vimdoc", "query",
          "json", "toml", "yaml", "csv", "bash", "markdown",
          "c", "cpp",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
      })
    end
  },

  -- LSP Zero for easy LSP setup
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      lsp_zero.on_attach(function(client, bufnr)
        local opts = {buffer = bufnr, remap = false}
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'rust_analyzer',
          'pyright', -- More reliable than pylsp
          'lua_ls',
          'jsonls',
          'taplo', -- TOML
          'yamlls',
          'clangd', -- C / C++
        },
        handlers = {
          lsp_zero.default_setup,

          -- Rust analyzer with cargo check
          rust_analyzer = function()
            require('lspconfig').rust_analyzer.setup({
              settings = {
                ['rust-analyzer'] = {
                  cargo = {
                    allFeatures = true,
                  },
                  checkOnSave = {
                    command = "cargo clippy",
                  },
                }
              }
            })
          end,

          -- Python with virtual environment support
          pyright = function()
            require('lspconfig').pyright.setup({
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                    autoImportCompletions = true,
                  }
                }
              },
              on_init = function(client)
                -- Use the virtual environment Python if available
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                  client.config.settings.python.pythonPath = venv .. "/bin/python"
                end
              end,
            })
          end,

          -- JSON with schema support
          jsonls = function()
            require('lspconfig').jsonls.setup({
              settings = {
                json = {
                  schemas = require('schemastore').json.schemas(),
                  validate = { enable = true },
                }
              }
            })
          end,

          -- C / C++ with clangd
          clangd = function()
            require('lspconfig').clangd.setup({
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
              },
            })
          end,
        }
      })

      local cmp = require('cmp')
      local cmp_select = {behavior = cmp.SelectBehavior.Select}

      cmp.setup({
        sources = {
          {name = 'path'},
          {name = 'nvim_lsp'},
          {name = 'nvim_lua'},
          {name = 'buffer', keyword_length = 3},
          {name = 'luasnip', keyword_length = 2},
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif require('luasnip').expand_or_jumpable() then
              require('luasnip').expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
              require('luasnip').jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
      })
    end
  },

  -- LSP Lines for better diagnostic display
  {
    "lsp_lines.nvim",
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = false,  -- Load immediately
    priority = 999, -- Load early but after LSP
    config = function()
      require("lsp_lines").setup()
      -- Start with virtual lines OFF by default
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
      })
    end,
  },

  -- JSON schema support
  {
    "b0o/schemastore.nvim",
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      }
      vim.keymap.set('n', '<leader>pv', ':NvimTreeToggle<CR>')
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- Function to get current Python virtual environment
      local function get_venv()
        local venv = os.getenv("VIRTUAL_ENV")
        if venv then
          return "🐍 " .. vim.fn.fnamemodify(venv, ":t")
        end
        -- Check for conda environment
        local conda_env = os.getenv("CONDA_DEFAULT_ENV")
        if conda_env and conda_env ~= "base" then
          return "🐍 " .. conda_env
        end
        return ""
      end

      require('lualine').setup({
        options = {
          theme = 'tokyonight'
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {get_venv, 'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'rounded',   -- 'single', 'double', 'rounded', 'solid', 'shadow'
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = "Next git hunk"})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true, desc = "Previous git hunk"})

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, { desc = "Stage hunk" })
          map('n', '<leader>hr', gs.reset_hunk, { desc = "Reset hunk" })
          map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage hunk" })
          map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset hunk" })
          map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
          map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
          map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
          map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle line blame" })
          map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })
          map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })

          -- Text object
          map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
        end
      })
    end
  },

  -- Rust-specific tools
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },

  -- Python-specific tools
  {
    'Vimjas/vim-python-pep8-indent',
    ft = "python",
  },

  -- Auto-pairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },

  -- Comment plugin
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- Which-key for keybinding help
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require("which-key").setup()
    end
  },

  -- CSV plugin
  {
    'chrisbra/csv.vim',
    ft = "csv",
  },

  -- Better terminal
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup{
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        direction = 'float',
        float_opts = {
          border = 'curved',
        },
      }
    end
  },

  -- Virtual environment selector
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('venv-selector').setup({
        auto_refresh = true,
        stay_on_this_version = false,
      })
    end,
    event = 'VeryLazy',
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>', desc = 'Select Python virtual environment' },
      { '<leader>vc', '<cmd>VenvSelectCached<cr>', desc = 'Select cached virtual environment' },
    },
  },
}

-- Load plugins
require("lazy").setup(plugins, {})

-- Auto-detect virtual environment (Method 1 support)
local function set_python_path()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    vim.g.python3_host_prog = venv .. "/bin/python"
    return venv .. "/bin/python"
  else
    -- Look for common virtual environment locations
    local cwd = vim.fn.getcwd()
    local possible_venvs = {
      cwd .. "/venv/bin/python",
      cwd .. "/.venv/bin/python",
      cwd .. "/env/bin/python",
      cwd .. "/.env/bin/python",
    }

    for _, python_path in ipairs(possible_venvs) do
      if vim.fn.executable(python_path) == 1 then
        vim.g.python3_host_prog = python_path
        return python_path
      end
    end

    vim.g.python3_host_prog = vim.fn.exepath("python3")
    return vim.fn.exepath("python3")
  end
end

local python_path = set_python_path()

-- Auto-command to update when changing directories
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function()
    local new_python_path = set_python_path()
    -- Restart LSP if Python path changed
    if new_python_path ~= python_path then
      python_path = new_python_path
      vim.cmd('LspRestart pyright')
    end
  end,
})

-- Auto-command to update when entering Python files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = set_python_path,
})

-- Key mappings
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", "<leader>pp", [["_dP]])  -- Changed from <leader>p to <leader>pp
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line to clipboard" })
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]], { desc = "Paste from clipboard" })
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]], { desc = "Paste before from clipboard" })
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Window splits
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>snv", ":vnew<CR>", { desc = "New vertical split" })
vim.keymap.set("n", "<leader>snh", ":new<CR>", { desc = "New horizontal split" })

-- Edit commands
vim.keymap.set("n", "<leader>ects", ":%s/\\s\\+$//e<CR>", { desc = "Clear trailing spaces" })

-- LSP diagnostics toggle
vim.keymap.set("n", "<leader>ll", function()
  local ok, lsp_lines = pcall(require, "lsp_lines")
  if not ok then
    vim.notify("lsp_lines plugin not loaded", vim.log.levels.WARN)
    return
  end

  local config = vim.diagnostic.config()

  -- Cycle through states: off → virtual_lines only → off
  if not config.virtual_text and not config.virtual_lines then
    -- State 1: Turn on virtual_lines only
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true,
    })
    vim.notify("LSP: virtual lines ON", vim.log.levels.INFO)
  else
    -- State 2: Turn everything off
    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = false,
    })
    vim.notify("LSP: diagnostics OFF", vim.log.levels.INFO)
  end
end, { desc = "Toggle LSP diagnostics" })

-- Stop pylsp LSP server
vim.keymap.set("n", "<leader>lk", function()
  vim.cmd("LspStop pylsp")
  vim.notify("Stopped pylsp", vim.log.levels.INFO)
end, { desc = "Stop pylsp LSP server" })

-- Restart LSP servers
vim.keymap.set("n", "<leader>lr", function()
  vim.cmd("LspRestart")
  vim.notify("LSP servers restarted", vim.log.levels.INFO)
end, { desc = "Restart LSP servers" })

-- Jump to next/previous error (not warning)
vim.keymap.set("n", "]e", function()
  vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})
end, { desc = "Next error" })

vim.keymap.set("n", "[e", function()
  vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})
end, { desc = "Previous error" })

-- Sort commands
vim.keymap.set("v", "<leader>so", ":sort<CR>", { desc = "Sort selected lines" })
vim.keymap.set("v", "<leader>sor", ":sort!<CR>", { desc = "Sort selected lines (reverse)" })
vim.keymap.set("v", "<leader>son", ":sort n<CR>", { desc = "Sort selected lines (numeric)" })
vim.keymap.set("v", "<leader>sou", ":sort u<CR>", { desc = "Sort selected lines (unique)" })
vim.keymap.set("v", "<leader>soi", ":sort i<CR>", { desc = "Sort selected lines (case-insensitive)" })
vim.keymap.set("v", "<leader>sonr", ":sort! n<CR>", { desc = "Sort selected lines (numeric reverse)" })

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"rust"},
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"python"},
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"json", "yaml", "toml"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"csv"},
  callback = function()
    vim.opt_local.nowrap = false
    vim.cmd("CSVTabularize")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"c", "cpp"},
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- Auto-format C/C++ on save via clangd (reads .clang-format if present)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx"},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
