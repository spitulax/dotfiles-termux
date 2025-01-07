-- From https://github.com/NvChad/NvChad/blob/v2.0/lua/core/utils.lua
local function lazy_load(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

local plugins = {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      no_italic = true,
    },
    priority = 1000,
  },

  {
    "windwp/nvim-autopairs",
    event = "BufRead",
    opts = {
      map_cr = true,
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim", version = "2.20.7",
    init = function()
      lazy_load("indent-blankline.nvim")
    end,
    opts = {
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    enable = false,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "python",
        "markdown",
        "norg",
        "bash",
        "fish",
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true },
    },
  },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    build = ":Neorg sync-parsers",
    version = "7.0.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      load = {
        ["core.defaults"] = {},
        ["core.concealer"] = {},
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/notes",
            },
          },
        },
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    opts = {
      modified = {
        enable = true,
        show_on_dirs = false,
      },
      view = {
        signcolumn = "auto",
      },
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = false,
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_modified = "name",
        root_folder_label = ":~:s?$?/..?",
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            git = true,
          },
          git_placement = "signcolumn",
          glyphs = {
            bookmark = "B",
            git = {
              unstaged = "U",
              staged = "S",
              unmerged = "D",
              renamed = "M",
              untracked = "?",
              deleted = "X",
              ignored = "",
            },
          },
        },
      },
    },
  },
}

require("lazy").setup(plugins, {
  defaults = { lazy = true },
})
