-- y3k -- a Lush colorscheme built only from the 16 colors of your terminal.
--
-- Source palette: Ratty, copied from the Ghostty "Y3K" theme
--   ~/dotfiles/ratty/.config/ratty/ratty.toml  ([theme.normal] / [theme.bright])
--
--   normal        bright
--   black    #282828  #7c6f64
--   red      #ff2e2e  #ff2e2e   (bright == normal for the 6 chromatic colors)
--   green    #8bb400  #8bb400
--   yellow   #ffc815  #ffc815
--   blue     #0029bd  #0029bd
--   magenta  #ff35a4  #ff35a4
--   cyan     #00d4ff  #00d4ff
--   white    #fff4e6  #fffbf6
--   foreground #fff4e6, background #282828, cursor #fff4e6
--
-- No other hues are introduced. The only extra colors are Lush HSL
-- derivations (lighten/darken/mix) of the 16 above -- mostly because
-- the raw Y3K blue #0029bd is unreadable on the #282828 background,
-- so functions/links use blue.lighten(35) (same hue, higher lightness).
--
-- Palette colors below use the hsl() variables defined above, so changing
-- a color only requires editing it in one place. Note hsl() round-trips
-- through HSL and can drift by 1-2 units per channel (#282828 -> #292929).
--
-- Load with:  :colorscheme y3k
-- Live-edit with :Lushify (see :h lush).

local lush = require("lush")
local hsl = lush.hsl

-- The 16 terminal colors ------------------------------------------------
local black = hsl("#282828") -- normal black / background
local red = hsl("#ff2e2e")
local green = hsl("#8bb400")
local yellow = hsl("#ffc815")
local blue = hsl("#0029bd")
local magenta = hsl("#ff35a4")
local cyan = hsl("#00d4ff")
local white = hsl("#fff4e6") -- normal white / foreground / cursor

local bright_black = hsl("#7c6f64") -- bright black: the only "gray"
local bright_white = hsl("#fffbf6") -- bright white

-- Derived shades (same hues, adjusted lightness / mixed toward black) --
local bg_soft = black.lighten(6) -- floats, popups, sign column
local bg_highlight = black.lighten(14) -- cursor line, status line
local blue_bright = blue.lighten(38) -- readable blue on black bg

---@diagnostic disable: undefined-global
return lush(function(injects)
  local sym = injects.sym
  return {
    -- Editor ----------------------------------------------------------------
    Normal { fg = white, bg = black },
    NormalFloat { fg = white, bg = bg_soft },
    NormalNC { fg = white, bg = black },
    SignColumn { fg = bright_black, bg = black },
    FoldColumn { fg = bright_black, bg = black },
    EndOfBuffer { fg = bright_black },
    NonText { fg = bright_black },
    Whitespace { fg = bright_black },
    VertSplit { fg = bright_black, bg = black },
    -- (WinSeparator is the modern name; define both)
    WinSeparator { fg = bright_black, bg = black },
    Directory { fg = cyan, gui = "bold" },
    Title { fg = bright_white, gui = "bold" },
    Cursor { fg = black, bg = white },
    CursorLine { bg = bg_highlight },
    CursorColumn { bg = bg_highlight },
    LineNr { fg = bright_black },
    LineNrAbove { fg = bright_black },
    LineNrBelow { fg = bright_black },
    CursorLineNr { fg = yellow, gui = "bold" },
    StatusLine { fg = white, bg = bg_highlight },
    StatusLineNC { fg = bright_black, bg = black },
    TabLine { fg = bright_black, bg = black },
    TabLineSel { fg = white, bg = bg_highlight, gui = "bold" },
    TabLineFill { fg = bright_black, bg = black },
    Visual { fg = white, bg = bright_black },
    VisualNOS { fg = white, bg = bright_black },
    Search { fg = black, bg = yellow },
    IncSearch { fg = black, bg = magenta },
    Substitute { fg = black, bg = red },
    CurSearch { fg = black, bg = yellow, gui = "bold" },
    MatchParen { fg = yellow, gui = "bold" },
    WildMenu { fg = black, bg = cyan },
    Pmenu { fg = white, bg = bg_soft },
    PmenuSel { fg = black, bg = cyan, gui = "bold" },
    PmenuKind { fg = cyan },
    PmenuExtra { fg = bright_black },
    PmenuSbar { bg = bg_soft },
    PmenuThumb { bg = bright_black },
    Folded { fg = bright_black, bg = bg_soft },
    Question { fg = cyan },
    MoreMsg { fg = green, gui = "bold" },
    ModeMsg { fg = white, gui = "bold" },
    WarningMsg { fg = yellow, gui = "bold" },
    ErrorMsg { fg = red, bg = black, gui = "bold" },
    -- Undercurl "sp" colors come from the same palette
    SpellBad { fg = red, gui = "undercurl" },
    SpellCap { fg = yellow, gui = "undercurl" },
    SpellLocal { fg = cyan, gui = "undercurl" },
    SpellRare { fg = magenta, gui = "undercurl" },

    -- Syntax (classic Vim groups) ------------------------------------------
    Comment { fg = bright_black, gui = "italic" },
    String { fg = green },
    Character { fg = green },
    Number { fg = yellow },
    Float { fg = yellow },
    Boolean { fg = yellow },
    Constant { fg = cyan },
    Identifier { fg = white },
    Function { fg = blue_bright, gui = "bold" },
    Statement { fg = magenta, gui = "bold" },
    Conditional { fg = magenta, gui = "bold" },
    Repeat { fg = magenta, gui = "bold" },
    Label { fg = magenta },
    Operator { fg = magenta },
    Keyword { fg = magenta, gui = "bold" },
    Exception { fg = magenta, gui = "bold" },
    Type { fg = yellow },
    StorageClass { fg = yellow },
    Structure { fg = yellow },
    Typedef { fg = yellow },
    PreProc { fg = magenta },
    Include { fg = magenta },
    Define { fg = magenta },
    Macro { fg = magenta },
    PreCondit { fg = magenta },
    Special { fg = cyan },
    SpecialChar { fg = cyan },
    SpecialComment { fg = bright_black, gui = "italic" },
    Delimiter { fg = bright_black },
    Debug { fg = red },
    Underlined { fg = cyan, gui = "underline" },
    Ignore { fg = bright_black },
    Error { fg = black, bg = red, gui = "bold" },
    Todo { fg = black, bg = yellow, gui = "bold" },

    -- Treesitter ------------------------------------------------------------
    sym("@comment") { fg = bright_black, gui = "italic" },
    sym("@string") { fg = green },
    sym("@string.escape") { fg = cyan },
    sym("@string.regex") { fg = cyan },
    sym("@character") { fg = green },
    sym("@number") { fg = yellow },
    sym("@boolean") { fg = yellow },
    sym("@float") { fg = yellow },
    sym("@constant") { fg = cyan },
    sym("@constant.builtin") { fg = cyan },
    sym("@variable") { fg = white },
    sym("@variable.builtin") { fg = cyan },
    sym("@variable.parameter") { fg = white },
    sym("@parameter") { fg = white },
    sym("@field") { fg = cyan },
    sym("@property") { fg = cyan },
    sym("@function") { fg = blue_bright, gui = "bold" },
    sym("@function.builtin") { fg = blue_bright, gui = "bold" },
    sym("@function.call") { fg = blue_bright },
    sym("@function.macro") { fg = magenta },
    sym("@method") { fg = blue_bright },
    sym("@method.call") { fg = blue_bright },
    sym("@constructor") { fg = yellow },
    sym("@keyword") { fg = magenta, gui = "bold" },
    sym("@keyword.function") { fg = magenta, gui = "bold" },
    sym("@keyword.operator") { fg = magenta, gui = "bold" },
    sym("@keyword.return") { fg = magenta, gui = "bold" },
    sym("@operator") { fg = magenta },
    sym("@type") { fg = yellow },
    sym("@type.builtin") { fg = yellow },
    sym("@type.definition") { fg = yellow },
    sym("@storageclass") { fg = yellow },
    sym("@structure") { fg = yellow },
    sym("@punctuation") { fg = bright_black },
    sym("@punctuation.delimiter") { fg = bright_black },
    sym("@punctuation.bracket") { fg = bright_black },
    sym("@punctuation.special") { fg = cyan },
    sym("@tag") { fg = magenta },
    sym("@tag.attribute") { fg = cyan },
    sym("@tag.delimiter") { fg = bright_black },
    sym("@label") { fg = magenta },
    sym("@exception") { fg = magenta, gui = "bold" },
    sym("@include") { fg = magenta },
    sym("@import") { fg = magenta },
    sym("@namespace") { fg = white },
    sym("@module") { fg = white },
    sym("@text") { fg = white },
    sym("@text.title") { fg = bright_white, gui = "bold" },
    sym("@text.strong") { fg = bright_white, gui = "bold" },
    sym("@text.emphasis") { fg = white, gui = "italic" },
    sym("@text.underline") { fg = cyan, gui = "underline" },
    sym("@text.uri") { fg = cyan, gui = "underline" },
    sym("@text.literal") { fg = green },
    sym("@text.reference") { fg = cyan },
    sym("@text.todo") { fg = black, bg = yellow, gui = "bold" },
    sym("@text.diff.add") { fg = green },
    sym("@text.diff.delete") { fg = red },
    sym("@markup.heading") { fg = bright_white, gui = "bold" },
    sym("@markup.heading.1") { fg = bright_white, gui = "bold" },
    sym("@markup.heading.2") { fg = yellow, gui = "bold" },
    sym("@markup.heading.3") { fg = cyan, gui = "bold" },
    sym("@markup.heading.4") { fg = magenta, gui = "bold" },
    sym("@markup.heading.5") { fg = green, gui = "bold" },
    sym("@markup.heading.6") { fg = blue_bright, gui = "bold" },
    sym("@markup.strong") { fg = bright_white, gui = "bold" },
    sym("@markup.emphasis") { fg = white, gui = "italic" },
    sym("@markup.link") { fg = cyan, gui = "underline" },
    sym("@markup.link.url") { fg = cyan, gui = "underline" },
    sym("@markup.raw") { fg = green },
    sym("@markup.list") { fg = magenta },
    sym("@markup.quote") { fg = bright_black, gui = "italic" },
    sym("@diff.plus") { fg = green },
    sym("@diff.minus") { fg = red },
    sym("@diff.delta") { fg = yellow },

    -- LSP / diagnostics ------------------------------------------------------
    DiagnosticError { fg = red, gui = "bold" },
    DiagnosticWarn { fg = yellow },
    DiagnosticInfo { fg = cyan },
    DiagnosticHint { fg = bright_black },
    DiagnosticOk { fg = green },
    DiagnosticVirtualTextError { fg = red, bg = red.mix(black, 85) },
    DiagnosticVirtualTextWarn { fg = yellow, bg = yellow.mix(black, 85) },
    DiagnosticVirtualTextInfo { fg = cyan, bg = cyan.mix(black, 85) },
    DiagnosticVirtualTextHint { fg = bright_black, bg = bg_soft },
    DiagnosticVirtualTextOk { fg = green, bg = green.mix(black, 85) },
    DiagnosticUnderlineError { fg = red, gui = "undercurl" },
    DiagnosticUnderlineWarn { fg = yellow, gui = "undercurl" },
    DiagnosticUnderlineInfo { fg = cyan, gui = "undercurl" },
    DiagnosticUnderlineHint { fg = bright_black, gui = "undercurl" },
    DiagnosticUnderlineOk { fg = green, gui = "undercurl" },
    DiagnosticSignError { fg = red, bg = black },
    DiagnosticSignWarn { fg = yellow, bg = black },
    DiagnosticSignInfo { fg = cyan, bg = black },
    DiagnosticSignHint { fg = bright_black, bg = black },
    DiagnosticSignOk { fg = green, bg = black },
    DiagnosticFloatingError { fg = red, bg = bg_soft },
    DiagnosticFloatingWarn { fg = yellow, bg = bg_soft },
    DiagnosticFloatingInfo { fg = cyan, bg = bg_soft },
    DiagnosticFloatingHint { fg = bright_black, bg = bg_soft },
    DiagnosticFloatingOk { fg = green, bg = bg_soft },
    LspReferenceText { bg = bg_highlight },
    LspReferenceRead { bg = bg_highlight },
    LspReferenceWrite { bg = bg_highlight },
    LspInlayHint { fg = bright_black, bg = bg_soft },
    LspCodeLens { fg = bright_black, gui = "italic" },
    LspSignatureActiveParameter { fg = yellow, gui = "bold" },
    -- Semantic tokens (fall back to the palette roles above)
    sym("@lsp.type.class") { fg = yellow },
    sym("@lsp.type.enum") { fg = yellow },
    sym("@lsp.type.interface") { fg = yellow },
    sym("@lsp.type.struct") { fg = yellow },
    sym("@lsp.type.typeParameter") { fg = yellow },
    sym("@lsp.type.property") { fg = cyan },
    sym("@lsp.type.macro") { fg = magenta },
    sym("@lsp.mod.readonly") { fg = bright_black },
    sym("@lsp.mod.static") { fg = yellow },

    -- Diff / VCS ------------------------------------------------------------
    DiffAdd { fg = green, bg = green.mix(black, 82) },
    DiffChange { fg = yellow, bg = yellow.mix(black, 82) },
    DiffDelete { fg = red, bg = red.mix(black, 82) },
    DiffText { fg = white, bg = magenta.mix(black, 70), gui = "bold" },
    diffAdded { fg = green },
    diffRemoved { fg = red },
    diffChanged { fg = yellow },
    diffFile { fg = cyan, gui = "bold" },
    diffNewFile { fg = green, gui = "bold" },
    diffLine { fg = bright_black },
    GitSignsAdd { fg = green, bg = black },
    GitSignsChange { fg = yellow, bg = black },
    GitSignsDelete { fg = red, bg = black },
    GitSignsChangedelete { fg = yellow, bg = black },
    GitSignsTopdelete { fg = red, bg = black },
    GitSignsUntracked { fg = bright_black, bg = black },

    -- Quickfix / locations --------------------------------------------------
    QuickFixLine { bg = bg_highlight },
    qfFileName { fg = cyan, gui = "bold" },
    qfLineNr { fg = yellow },

    -- Plugins -----------------------------------------------------------------
    -- Telescope
    TelescopeNormal { fg = white, bg = bg_soft },
    TelescopeBorder { fg = bright_black, bg = bg_soft },
    TelescopePromptNormal { fg = white, bg = bg_soft },
    TelescopePromptBorder { fg = cyan, bg = bg_soft },
    TelescopePromptTitle { fg = cyan, gui = "bold" },
    TelescopePreviewTitle { fg = magenta, gui = "bold" },
    TelescopeResultsTitle { fg = yellow, gui = "bold" },
    TelescopeSelection { fg = black, bg = cyan, gui = "bold" },
    TelescopeSelectionCaret { fg = black, bg = cyan, gui = "bold" },
    TelescopeMatching { fg = yellow, gui = "bold" },
    -- NvimTree
    NvimTreeNormal { fg = white, bg = black },
    NvimTreeFolderName { fg = blue_bright },
    NvimTreeFolderArrow { fg = bright_black },
    NvimTreeOpenedFolderName { fg = blue_bright, gui = "bold" },
    NvimTreeFileName { fg = white },
    NvimTreeFileNameOpened { fg = yellow, gui = "bold" },
    NvimTreeGitNewFile { fg = green },
    NvimTreeGitRenamedFile { fg = yellow },
    NvimTreeGitDeletedFile { fg = red },
    NvimTreeGitModifiedFile { fg = magenta },
    NvimTreeGitUntrackedFile { fg = bright_black },
    NvimTreeGitIgnoredFile { fg = bright_black },
    NvimTreeSpecialFile { fg = cyan, gui = "bold" },
    NvimTreeSymlink { fg = cyan },
    NvimTreeIndentMarker { fg = bright_black },
    NvimTreeRootFolder { fg = magenta, gui = "bold" },
    -- BufferLine (current tabline plugin)
    BufferCurrent { fg = white, bg = bg_highlight, gui = "bold" },
    BufferVisible { fg = white, bg = black },
    BufferHidden { fg = bright_black, bg = black },
    BufferIndicator { fg = yellow },
    BufferCloseButton { fg = red },
    BufferModified { fg = yellow },
    BufferVisibleModified { fg = yellow },
    BufferCurrentSign { fg = yellow },
    -- Indent guides
    IndentBlanklineChar { fg = bright_black },
    IndentBlanklineContextChar { fg = bright_black },
    IndentBlanklineContextStart { fg = bright_black, gui = "underline" },
    -- Dashboard
    DashboardHeader { fg = magenta, gui = "bold" },
    DashboardCenter { fg = white },
    DashboardShortcut { fg = cyan },
    DashboardFooter { fg = bright_black, gui = "italic" },
    -- Flash
    FlashLabel { fg = black, bg = yellow, gui = "bold" },
    FlashMatch { fg = black, bg = magenta },
    FlashCurrent { fg = black, bg = yellow, gui = "bold" },
    FlashBackdrop { fg = bright_black },
    FlashPrompt { fg = cyan, bg = bg_soft },
    -- vim-illuminate
    IlluminatedWordText { bg = bg_highlight },
    IlluminatedWordRead { bg = bg_highlight },
    IlluminatedWordWrite { bg = bg_highlight },
    -- Mason
    MasonNormal { fg = white, bg = bg_soft },
    MasonHeader { fg = black, bg = cyan, gui = "bold" },
    MasonHeaderSecondary { fg = black, bg = magenta, gui = "bold" },
    MasonMuted { fg = bright_black },
    MasonMutedBlock { fg = black, bg = bright_black },
    MasonError { fg = red },
    MasonHeading { fg = white, gui = "bold" },
    -- Undotree
    UndotreeNode { fg = white },
    UndotreeNodeCurrent { fg = yellow, gui = "bold" },
    UndotreeNodeVisited { fg = bright_black },
    UndotreeCurrent { fg = yellow, gui = "bold" },
    UndotreeTimeStamp { fg = bright_black },
    UndotreeSelected { fg = black, bg = cyan },
    UndotreeSaved { fg = green },
    -- Markview (markdown)
    MarkviewHeading1 { fg = bright_white, gui = "bold" },
    MarkviewHeading2 { fg = yellow, gui = "bold" },
    MarkviewHeading3 { fg = cyan, gui = "bold" },
    MarkviewHeading4 { fg = magenta, gui = "bold" },
    MarkviewHeading5 { fg = green, gui = "bold" },
    MarkviewHeading6 { fg = blue_bright, gui = "bold" },
    MarkviewCode { fg = green, bg = bg_soft },
    MarkviewInlineCode { fg = green, bg = bg_soft },
    MarkviewLink { fg = cyan, gui = "underline" },
    MarkviewListMarker { fg = magenta },
    MarkviewBlockquote { fg = bright_black, gui = "italic" },
    MarkviewHorizontalRule { fg = bright_black },
  }
end)
