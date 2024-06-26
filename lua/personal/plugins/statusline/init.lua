return {
  "NoseferatuWKF/neoline.nvim",
  dependencies = {
    "tjdevries/express_line.nvim",
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local builtin = require("el.builtin")
    local sections = require("el.sections")
    local neoline = require("neoline")

    require("el").setup {
      generator = function(_, buffer)
        -- see :highlight
        local highlights = {
          magenta = neoline.extract_hl({
            bg = { ["StatusLine"] = "bg" },
            fg = { ["ErrorMsg"] = "fg" },
            bold = true,
          }),
          green = neoline.extract_hl({
            bg = { ["StatusLine"] = "bg" },
            fg = { ["DiffAdd"] = "fg" },
            bold = true,
          }),
          yellow = neoline.extract_hl({
            bg = { ["StatusLine"] = "bg" },
            fg = { ["WarningMsg"] = "fg" },
            bold = true,
          }),
          blue = neoline.extract_hl({
            bg = { ["StatusLine"] = "bg" },
            fg = { ["Directory"] = "fg" },
            bold = true,
          }),
          null = neoline.extract_hl({
            bg = { ["StatusLine"] = "bg" },
            bold = true,
          })
        }

        local modes = {
          n      = { "Normal", "N", { highlights.null } },
          v      = { "Visual", "V", { highlights.blue } },
          V      = { "V·Line", "Vl", { highlights.blue } },
          [""] = { "V·Block", "Vb", { highlights.blue } },
          i      = { "Insert", "I", { highlights.magenta } },
          R      = { "Replace", "R", { highlights.magenta, "IncSearch" } },
          c      = { "Command", "C", { highlights.green, "DiffAdd" } },
          nt     = { "Term  ", "T", { highlights.green, "diffAdded" } },
          t      = { "Term  ", "T", { highlights.green, "diffAdded" } },
        }

        local components = {
          { neoline.mode { modes = modes, fmt = " %s %s ", icon = "󰻽", hl_icon_only = false } },
          { neoline.git_branch { fmt = " %s %s ", icon = "", hl = highlights.yellow } },
          { neoline.git_changes {
            fmt = "|%s|",
            icon_insert = "+",
            icon_change = "~",
            icon_delete = "-",
            hl_insert = { highlights.green },
            hl_change = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiffChange"] = "fg" },
              bold = true,
            }),
            hl_delete = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiffDelete"] = "fg" },
              bold = true,
            }),
          }},
          { sections.split },
          { neoline.file_icon { fmt = "%s ", hl_icon = true } },
          { sections.maximum_width(builtin.file_relative, 0.25) },
          { sections.collapse_builtin { { " " }, { builtin.modified_flag } } },
          { sections.split },
          { neoline.diagnostics {
            fmt = "|%s|", lsp = true,
            hl_err = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiagnosticError"] = "fg" },
              bold = true,
            }),
            hl_warn = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiagnosticWarn"] = "fg" },
              bold = true,
            }),
            hl_info = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiagnosticInfo"] = "fg" },
              bold = true,
            }),
            hl_hint = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiagnosticHint"] = "fg" },
              bold = true,
            }),
            icon_err = '', icon_warn = '', icon_info = '', icon_hint = '󰌵',
          }},
          { neoline.line_number { modes = modes, ln = builtin.line, col = builtin.column, fmt = " %s:%s " }},
        }

        local result = {}
        for _, item in ipairs(components) do
          table.insert(result, item)
        end

        return result
      end
    }
  end
}
