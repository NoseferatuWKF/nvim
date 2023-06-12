return {
  "tjdevries/express_line.nvim",
  dependencies = {
    "NoseferatuWKF/neoline.nvim",
  },
  config = function()
    local builtin = require("el.builtin")
    local sections = require("el.sections")
    local neoline = require("neoline")

    require("el").setup {

      -- disable statusline on these windows
      -- regenerate_autocmds = { "WinEnter", "WinLeave" },
      generator = function(_, buffer)
        -- local is_inactive = vim.o.laststatus ~= 3 and window.win_id ~= vim.api.nvim_get_current_win()

        local is_inactive = false
        if not is_inactive then
          for _, ft in ipairs({
            "fugitive",
            "fugitiveblame",
          }) do
            if vim.bo[buffer.bufnr].ft == ft then
              is_inactive = true
            end
          end
        end

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
          { neoline.git_changes_buf {
            fmt = "|%s|",
            icon_insert = "+",
            icon_change = "~",
            icon_delete = "-",
            hl_insert = neoline.extract_hl({
              bg = { ["StatusLine"] = "bg" },
              fg = { ["DiffAdd"] = "fg" },
              bold = true,
            }),
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
          { sections.split, required = true },
          { neoline.file_icon { fmt = "%s ", hl_icon = true } },
          { sections.maximum_width(builtin.file_relative, 0.25), required = true },
          { sections.collapse_builtin { { " " }, { builtin.modified_flag } } },
          { sections.split, required = true },
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

        local add_item = function(result, item)
          if is_inactive and not item.required then
            return
          end

          table.insert(result, item)
        end

        local result = {}
        for _, item in ipairs(components) do
          add_item(result, item)
        end

        return result
      end,
    }
  end
}
