--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = { "*.lua", "*.tsx", "*.jsx", "*.ts", "*.js" },
  timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<M-f>"] = ":Prettier<CR>"
lvim.keys.normal_mode["<M-e>"] = ":TroubleToggle<CR>"
lvim.keys.normal_mode["<M-s>"] = ":vsplit<CR>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "tokyonight"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- lvim.builtin.lualine.style = "none"
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.options.theme = "powerline_dark"
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.component_separators = "|"
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }
lvim.builtin.lualine.sections = {
  lualine_a = {
    { 'mode' },
  },
  lualine_b = { 'filename', 'branch' },
  lualine_c = { 'fileformat' },
  lualine_x = { components.lsp, components.diagnostics, 'encoding' },
  lualine_y = { 'filetype', 'progress' },
  lualine_z = {
    { 'location' },
  },
}
lvim.builtin.lualine.inactive_sections = {
  lualine_a = { 'filename' },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = { 'location' },
}


-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true
lvim.builtin.alpha.dashboard.section.header.val = {

  "██╗     ██╗   ██╗███╗   ██╗ █████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
  "██║     ██║   ██║████╗  ██║██╔══██╗██╔══██╗██║   ██║██║████╗ ████║",
  "██║     ██║   ██║██╔██╗ ██║███████║██████╔╝██║   ██║██║██╔████╔██║",
  "██║     ██║   ██║██║╚██╗██║██╔══██║██╔══██╗╚██╗ ██╔╝██║██║╚██╔╝██║",
  "███████╗╚██████╔╝██║ ╚████║██║  ██║██║  ██║ ╚████╔╝ ██║██║ ╚═╝ ██║",
  "╚══════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"

}

-- diagnostics float
vim.diagnostic.config({virtual_text = false})
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  -- { command = "stylua" },
  {
    command = "prettier",
    extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     command = "shellcheck",
--     args = { "--severity", "warning" },
--   },
-- }

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup {
        {
          position = "bottom",            -- position of the list can be: bottom, top, left, right
          height = 10,                    -- height of the trouble list when position is top or bottom
          width = 50,                     -- width of the list when position is left or right
          icons = true,                   -- use devicons for filenames
          mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
          fold_open = "",              -- icon used for open folds
          fold_closed = "",            -- icon used for closed folds
          group = true,                   -- group results by file
          padding = true,                 -- add an extra new line on top of the list
          action_keys = {
            -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q",                     -- close the list
            cancel = "<esc>",                -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r",                   -- manually refresh
            jump = { "<cr>", "<tab>" },      -- jump to the diagnostic or open / close folds
            open_split = { "<c-x>" },        -- open buffer in new split
            open_vsplit = { "<c-v>" },       -- open buffer in new vsplit
            open_tab = { "<c-t>" },          -- open buffer in new tab
            jump_close = { "o" },            -- jump to the diagnostic and close the list
            toggle_mode = "m",               -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P",            -- toggle auto_preview
            hover = "K",                     -- opens a small popup with the full multiline message
            preview = "p",                   -- preview the diagnostic location
            close_folds = { "zM", "zm" },    -- close all folds
            open_folds = { "zR", "zr" },     -- open all folds
            toggle_fold = { "zA", "za" },    -- toggle fold of current file
            previous = "k",                  -- previous item
            next = "j"                       -- next item
          },
          indent_lines = true,               -- add an indent guide below the fold icons
          auto_open = false,                 -- automatically open the list when you have diagnostics
          auto_close = false,                -- automatically close the list when you have no diagnostics
          auto_preview = true,               -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
          auto_fold = false,                 -- automatically fold a file trouble list at creation
          auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
          signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
          },
          use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
        }
      }
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        transparent_mode = true
      })
      lvim.colorscheme = "gruvbox"
    end
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        autotag = {
          enable = true,
        }
      }
    end,
  },
  { "prisma/vim-prisma" },
  { "jparise/vim-graphql" },
  { "MunifTanjim/prettier.nvim" }
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
