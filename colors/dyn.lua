-- Dynamic Material 3 colorscheme.
--
-- Reads the palette that matugen generates from the current wallpaper and
-- hands it to mini.base16, then overlays the highlight groups whose colour
-- carries MEANING rather than decoration.
--
-- The generated file deliberately lives OUTSIDE this repo, in
-- $XDG_STATE_HOME/theme/. This directory is a git submodule with its own
-- remote; generating into it would dirty the submodule (and therefore the
-- parent's pointer) on every wallpaper change.
--
-- Falls back to catppuccin if the palette is absent - a fresh clone, or
-- retheme never having run - so `:colorscheme dyn` can never error.

local state = vim.env.XDG_STATE_HOME or (vim.env.HOME .. "/.local/state")
local file = state .. "/theme/nvim-palette.lua"

local ok, spec = pcall(dofile, file)
if not ok or type(spec) ~= "table" or type(spec.base16) ~= "table" then
  vim.notify("dyn: no generated palette at " .. file .. " - using catppuccin",
    vim.log.levels.WARN)
  pcall(vim.cmd.colorscheme, "catppuccin")
  return
end

require("mini.base16").setup({ palette = spec.base16, use_cterm = true })
-- AFTER setup(): mini.base16 sets colors_name itself, so setting it first is
-- silently overwritten. Plugins that branch on it (lualine's theme = "auto")
-- need it to be ours.
vim.g.colors_name = "dyn"

local s, m = spec.semantic, spec.m3
local hl = function(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- Semantics: pinned, never wallpaper-driven.
hl("DiagnosticError", { fg = s.error })
hl("DiagnosticWarn", { fg = s.warn })
hl("DiagnosticInfo", { fg = s.info })
hl("DiagnosticHint", { fg = s.hint })
hl("DiagnosticUnderlineError", { sp = s.error, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = s.warn, undercurl = true })

hl("DiffAdd", { fg = s.add, bg = spec.base16.base01 })
hl("DiffChange", { fg = s.change, bg = spec.base16.base01 })
hl("DiffDelete", { fg = s.delete, bg = spec.base16.base01 })
hl("DiffText", { fg = s.change, bg = spec.base16.base02, bold = true })
hl("Added", { fg = s.add })
hl("Changed", { fg = s.change })
hl("Removed", { fg = s.delete })
hl("GitSignsAdd", { fg = s.add })
hl("GitSignsChange", { fg = s.change })
hl("GitSignsDelete", { fg = s.delete })

-- Chrome: free to follow the wallpaper.
hl("Visual", { bg = m.primary_container })
hl("CursorLine", { bg = spec.base16.base01 })
hl("Search", { fg = m.on_tertiary_container, bg = m.tertiary_container })
hl("IncSearch", { fg = m.on_tertiary, bg = m.tertiary })
hl("CurSearch", { fg = m.on_tertiary, bg = m.tertiary })
hl("MatchParen", { fg = m.primary, bold = true })
hl("WinSeparator", { fg = m.outline })
hl("FloatBorder", { fg = m.outline, bg = spec.base16.base01 })
hl("NormalFloat", { bg = spec.base16.base01 })
hl("Pmenu", { bg = spec.base16.base01, fg = spec.base16.base05 })
hl("PmenuSel", { bg = m.primary_container, fg = m.on_primary_container })
