require('table')
require('BufferHelpers')
require('dashboard')

local colors = require('theme').colors
local theme = require('theme').theme

vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"
vim.g.neovide_cursor_animation_length = 0.05
vim.opt.termguicolors = true
vim.opt.showmode = true
vim.opt.updatetime = 200
vim.lsp.inlay_hint.enable(true)
vim.opt.timeoutlen = 300
vim.diagnostic.config({
  virtual_text = false,
})

require("supermaven-nvim").setup({
  ignore_filetypes = {
    help = true,
    startify = true,
    dashboard = true,
    packer = true,
    neogitstatus = true,
    Prompt = true,
    NvimTree = true,
    Trouble = true,
    alpha = true,
    lir = true,
    Outline = true,
    aerial = true,
    spectre_panel = true,
    toggleterm = true,
    qf = true,
    dapui_hover = true,
    TelescopePrompt = true,
  },
  color = {
    suggestion_color = colors.base03,
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.nu = {
  filetype = "nu",
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end
})

-- Define a function to check that ollama is installed and working
local function get_condition()
  return package.loaded["ollama"] and require("ollama").status ~= nil
end

-- Define a function to check the status and return the corresponding icon
local function get_status_icon()
  local status = require("ollama").status()

  if status == "IDLE" then
    return "  IDLE"
  elseif status == "WORKING" then
    return "  BUSY"
  end
end

require('lualine').setup {
  options = {
    theme = require('theme').theme,
    icons_enabled = true,
    component_separators = '┃',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { statusline = { "NvimTree", "Trouble", "startup" }, winbar = { "NvimTree", "Trouble" } },
    always_divide_middle = true,
    globalstatus = true,

    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },

  sections = {
    lualine_a = {
      {
        'mode',
        separator = { left = '', right = '┃' },
        right_padding = 3,
        left_padding = 3,
      }
    },
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        symbols = { error = ' ', warn = ' ', info = ' ' },
      },
    },
    lualine_c = { { 'filename', separator = { right = '' } } },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {
      {
        'location',
        separator = {
          right = ''
        }
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
  --
  -- sections = {
  --   lualine_a = {
  --     {
  --       'mode',
  --       separator = { left = '' },
  --       right_padding = 5,
  --       left_padding = 5,
  --     }
  --   },
  --   lualine_b = {
  --     'branch',
  --     'diff',
  --     {
  --       'diagnostics',
  --       sources = { 'nvim_diagnostic' },
  --       symbols = { error = ' ', warn = ' ', info = ' ' },
  --     }
  --   },
  --   lualine_c = {
  --     {
  --       'filetype',
  --       'progress',
  --     },
  --     {
  --       'filename',
  --       file_status = true,
  --       path = 1
  --     }
  --   },
  --   lualine_x = {},
  --   lualine_y = {
  --     get_status_icon,
  --   },
  --   lualine_z = {
  --     {
  --       'location',
  --       separator = { right = '' },
  --       left_padding = 5
  --     }
  --   },
  -- },
  -- inactive_sections = {
  --   lualine_a = { 'filename' },
  --   lualine_b = {},
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = {},
  --   lualine_z = { 'location' },
  -- },
  -- tabline = {},
  -- extensions = {},
}

-- Define the function to set iskeyword
-- This function will append the given list of characters to
-- the iskeyword option for the given filetype
--
-- args:
--   - filetype (string): The filetype to set iskeyword for
--   - chars (string): The list of characters to append to IsKeyword
--
--
--   Example:
--   set_iskeyword('markdown', { '-', '.' })
--
vim.api.nvim_create_augroup('FileTypeIsKeyword', { clear = true })

local function set_iskeyword(chars, filetype)
  if filetype then
    -- Set iskeyword for a specific filetype
    vim.api.nvim_create_autocmd('FileType', {
      pattern = filetype,
      callback = function()
        for _, char in ipairs(chars) do
          vim.opt_local.iskeyword:append(char)
        end
      end,
      group = 'FileTypeIsKeyword'
    })
  else
    -- Set iskeyword globally
    for _, char in ipairs(chars) do
      vim.opt.iskeyword:append(char)
    end
  end
end

local function CloseAndSaveBuffer()
  if vim.bo.modified then
    if vim.fn.bufname() ~= "" then
      local choice = vim.fn.confirm("You have unsaved changes. Save before closing?", "&Yes\n&No\n&Cancel")

      if choice == 1 then
        vim.cmd('w')
        vim.cmd('bd')
      elseif choice == 2 then
        vim.cmd('bd!')
      else
        return
      end
    else
      local filename = vim.fn.input("Your buffer is unnamed, enter a filename: ")
      if filename ~= "" then
        vim.cmd('saveas ' .. filename)
        vim.cmd('bd')
      else
        print("No filename provided. Aborting...")
        return
      end
    end
  else
    vim.cmd('bd')
  end
end

vim.api.nvim_create_user_command('CloseAndSaveBuffer', CloseAndSaveBuffer, {})
