-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.lsp.installer.setup.automatic_installation = false
lvim.builtin.lualine.options.theme = "powerline_dark"

-- LSP setup
require("lvim.lsp.manager").setup("marksman")

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>Trouble<cr>", "trouble" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "document" },
  q = { "<cmd>Trouble quickfix<cr>", "quickfix" },
  l = { "<cmd>Trouble loclist<cr>", "loclist" },
  r = { "<cmd>Trouble lsp_references<cr>", "references" },
}

-- lvim.builtin.lualine.style = "none"
lvim.builtin.lualine.options.theme = "powerline_dark"
lvim.builtin.lualine.options.globalstatus = true
lvim.builtin.lualine.options.component_separators = "|"
lvim.builtin.lualine.options.section_separators = { left = '', right = '' }

--formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "100" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "typescript", "typescriptreact", "json", "markdown" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}

--override <leader>lf
lvim.builtin.which_key.mappings["l"]["f"] = {
  function()
    require("lvim.lsp.utils").format { timeout_ms = 2000 }
  end,
  "Format",
}

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.lua", "*.tsx", "*.jsx", "*.ts", "*.js", "*.json", "*.md", "*.prisma" }

lvim.transparent_window = true
lvim.plugins = {
  { "rest-nvim/rest.nvim" },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- require("kanagawa").setup({
  --     --   transparent = true
  --     -- })
  --     lvim.colorscheme = "kanagawa-wave"
  --   end
  -- },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      -- require("github-theme").setup({
      --   options = {
      --     transparent = true
      --   }
      -- })
      lvim.colorscheme = "github_dark_tritanopia"
    end
  },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("nightfox").setup({
  --       options = {
  --         transparent = true
  --       }
  --     })
  --     lvim.colorscheme = "nightfox"
  --   end
  -- },
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
  {
    "folke/trouble.nvim",
    cmd = "Trouble"
  },
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = function()
      require("glow").setup({
        border = "rounded",
        style = "dark"
      })
    end
  }
}
