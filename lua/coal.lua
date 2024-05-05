local M = {}

local function reset()
	vim.api.nvim_command("hi clear")

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.cmd("set termguicolors")
end

local function expand_highlight_command_with(cmd, pattern, value)
	if value == nil then
		return
	end
	table.insert(cmd, string.format("%s=%s", pattern, value))
end

function M.setup(config)
	reset()

	config = config or {}
	local cc = config.colors or {}

	local colors = {
		smoky_black = cc.smoky_black or "#0C0C0C",
		eerie_black = cc.eerie_black or "#1A1A1A",
		raisin_black = cc.raisin_black or "#262626",

		dark_charcoal = cc.dark_charcoal or "#303030",
		search_blue = "#3E68D7",
		gray = "#7E7E7E",
		quick_silver = cc.quick_silver or "#A5A5A5",
		chinese_silver = cc.chinese_silver or "#CCCCCC",
		anti_flash_white = cc.anti_flash_white or "#F2F2F2",
		white = cc.white or "#FFFFFF",
	}

	local palette = {
		selection = {
			foreground = colors.smoky_black,
			background = colors.anti_flash_white,
		},
		lighter_selection = {
			foreground = colors.white,
			background = colors.dark_charcoal,
		},
		search_selection = {
			foreground = colors.white,
			background = colors.search_blue,
		},
		background = {
			medium = colors.smoky_black,
			brighter = colors.eerie_black,
			brightest = colors.raisin_black,
		},
		foreground = {
			darkest = colors.dark_charcoal,
			darker = colors.gray,
			dimmed = colors.quick_silver,
			medium = colors.chinese_silver,
			brighter = colors.anti_flash_white,
			brightest = colors.white,
		},
	}

	local groups = {
		normal = { fg = palette.foreground.medium, bg = palette.background.medium },
		selection = { fg = palette.selection.foreground, bg = palette.selection.background },
		lighter_selection = { fg = palette.lighter_selection.foreground, bg = palette.lighter_selection.background },
		search_selection = { fg = palette.search_selection.foreground, bg = palette.search_selection.background },
		darkest = { fg = palette.foreground.darkest },
		darker = { fg = palette.foreground.darker },
		darker_italic = { fg = palette.foreground.darker, em = "italic" },
		dimmed = { fg = palette.foreground.dimmed },
		dimmed_italic = { fg = palette.foreground.dimmed, em = "italic" },
		medium = { fg = palette.foreground.medium },
		medium_italic = { fg = palette.foreground.medium, em = "italic" },
		medium_bold = { fg = palette.foreground.medium, em = "bold" },
		medium_underline = { fg = palette.foreground.medium, em = "underline" },
		brighter = { fg = palette.foreground.brighter },
		brighter_italic = { fg = palette.foreground.brighter, em = "italic" },
		brighter_bold = { fg = palette.foreground.brighter, em = "bold" },
		brightest = { fg = palette.foreground.brightest, em = "none" },
		brightest_bold = { fg = palette.foreground.brightest, em = "bold" },
	}
	local higlight_groups = {
		Normal = groups.normal,

		Bold = { em = "bold" },
		Italic = { em = "italic" },
		Underlined = { em = "underline" },

		Visual = groups.lighter_selection,

		Directory = groups.brighter,

		IncSearch = groups.search_selection,
		Search = groups.search_selection,
		Substitute = groups.search_selection,

		MatchParen = { fg = "#FF9E64", bg = "none" },

		ModeMsg = groups.brighter,
		MoreMsg = groups.brighter,
		NonText = { fg = palette.foreground.darkest },

		LineNr = groups.dimmed,
		LineNrAbove = groups.darkest,
		LineNrBelow = groups.darkest,
		CursorLineNr = groups.darker,

		StatusLine = { fg = palette.foreground.medium, bg = palette.background.brighter },
		StatusLineNC = { fg = palette.foreground.darkest, bg = palette.background.brighter },
		WinSeparator = { fg = palette.foreground.darkest, bg = palette.background.medium },
		SignColumn = groups.normal,
		Colorcolumn = { bg = palette.background.brighter },

		TabLineFill = { bg = palette.background.brightest },
		TabLine = { fg = palette.foreground.dimmed, bg = palette.background.brightest },
		TabLineSel = { fg = palette.foreground.medium },

		Pmenu = { fg = palette.foreground.medium, bg = palette.background.brightest },
		PmenuSel = groups.lighter_selection,
		PmenuSbar = { bg = palette.background.brightest },

		Conceal = groups.darker,
		Title = groups.brighter,
		Question = groups.brighter,
		SpecialKey = groups.darkest,
		WildMenu = { fg = palette.foreground.medium, bg = palette.background.brightest },
		Folded = { fg = palette.foreground.darker, bg = palette.background.brighter },
		FoldColumn = { fg = palette.foreground.darkest, bg = palette.background.medium },

		-- Spelling
		SpellBad = { em = "underline" },
		SpellLocal = { em = "underline" },
		SpellCap = { em = "underline" },
		SpellRare = { em = "underline" },

		-- Syntax
		Boolean = groups.brighter,
		Character = groups.brighter,
		Comment = groups.darker_italic,
		Conditional = groups.dimmed,
		Constant = groups.brighter,
		Variable = groups.medium_italic,
		Define = groups.darker,
		Delimiter = groups.darker,
		Float = groups.brighter,
		Function = groups.brighter_italic,
		Identifier = groups.medium,
		Include = groups.darker,
		Keyword = groups.dimmed,
		Label = groups.darker,
		Number = groups.brighter,
		Operator = groups.darker,
		PreProc = groups.darker,
		Repeat = groups.darker,
		Special = groups.brighter,
		SpecialChar = groups.brighter,
		Statement = groups.medium,
		StorageClass = groups.brighter,
		String = groups.brighter,
		Structure = groups.brighter,
		Tag = groups.medium,
		Todo = groups.brightest,
		Type = groups.brighter,
		Typedef = groups.brighter,

		-- TreeSitter
		TSAnnotation = groups.darker_italic,
		TSAttribute = groups.darker,
		TSBoolean = groups.brighter,
		TSCharacter = groups.brighter,
		TSCharacterSpecial = groups.brighter,
		TSComment = groups.darker_italic,
		TSConditional = groups.medium,
		TSConstant = groups.brighter,
		TSConstBuiltin = groups.brighter,
		TSConstMacro = groups.darker,
		TSConstructor = groups.brighter,
		TSDebug = groups.medium,
		TSDefine = groups.medium,
		TSError = groups.brightest,
		TSException = groups.brightest,
		TSField = groups.medium,
		TSFloat = groups.brighter,
		TSFunction = groups.brighter,
		TSFuncBuiltin = groups.brighter,
		TSFuncMacro = groups.brighter,
		TSInclude = groups.darker,
		TSKeyword = groups.dimmed,
		TSKeywordFunction = groups.dimmed,
		TSKeywordOperator = groups.dimmed,
		TSKeywordReturn = groups.dimmed,
		TSLabel = groups.darker,
		TSMethod = groups.brighter,
		TSNamespace = groups.darker,
		TSNone = groups.darkest,
		TSNumber = groups.brighter,
		TSOperator = groups.darker,
		TSParameter = groups.medium,
		TSParameterReference = groups.darker,
		TSPreProc = groups.darker,
		TSProperty = groups.medium,
		TSPunctDelimiter = groups.darker,
		TSPunctBracket = groups.darker,
		TSPunctSpecial = groups.darker,
		TSRepeat = groups.darker,
		TSStorageClass = groups.medium,
		TSString = groups.brighter,
		TSStringRegex = groups.brighter,
		TSStringEscape = groups.medium,
		TSStringSpecial = groups.medium,
		TSSymbol = groups.brighter,
		TSTag = groups.medium,
		TSTagAttribute = groups.darker,
		TSTagDelimiter = groups.darker,
		TSText = groups.medium,
		TSStrong = { em = "bold" },
		TSEmphasis = { em = "italic" },
		TSUnderline = { em = "underline" },
		TSStrike = { em = "strikethrough" },
		TSTitle = groups.brighter,
		TSLiteral = groups.brighter,
		TSURI = groups.medium_underline,
		TSMath = groups.darker,
		TSTextReference = groups.darker,
		TSEnvironment = groups.darker,
		TSEnvironmentName = groups.darker,
		TSNote = groups.medium,
		TSWarning = groups.brighter,
		TSDanger = groups.brightest,
		TSTodo = groups.brightest,
		TSType = groups.medium,
		TSTypeBuiltin = groups.medium,
		TSTypeQualifier = groups.darker,
		TSTypeDefinition = groups.medium,
		TSVariable = groups.medium_italic,
		TSVariableBuiltin = groups.medium_italic,

		-- Sementic
		["@variable"] = groups.medium_italic,
    ["@variable.builtin"] = groups.medium_bold,
		["@variable.parameter"] = groups.medium_italic,
		["@variable.member"] = groups.medium,

 		["@function"] = groups.brighter,
		["@function.builtin"] = groups.brighter_bold,
		["@function.macro"] = { link = "Function" },
		["@function.method"] = groups.brighter,
		["@function.method.call"] = groups.brighter,

		-- Diff
		DiffAdd = { bg = palette.background.brighter },
		DiffAdded = { fg = palette.foreground.medium },

		DiffDelete = { fg = palette.background.brighter, bg = palette.background.brighter },
		DiffRemoved = { fg = palette.foreground.darker },

		DiffChange = { bg = palette.background.brighter },
		DiffText = { fg = palette.background.medium, bg = palette.foreground.darker, em = "bold" },

		DiffLine = { fg = palette.foreground.darker },

		-- Telescope
		TelescopeSelectionCaret = { bg = palette.background.brightest },
		TelescopeSelection = { bg = palette.background.brightest },
		TelescopeMatching = groups.brightest_bold,

		-- Netrw
		netrwMarkFile = { bg = palette.background.brightest },

		-- LSP inlay hints
		LSPInlayHint = { fg = "#545C7E", bg = "none" },

		-- Nvim flash
		FlashLabel = { fg = "#ffffff", bg = "#ff007c", bold = true },
	}

	for group, set in pairs(higlight_groups) do
		local cmd = { "hi", group }

		expand_highlight_command_with(cmd, "guifg", set.fg)
		expand_highlight_command_with(cmd, "guibg", set.bg)
		expand_highlight_command_with(cmd, "gui", set.em or "none")
		expand_highlight_command_with(cmd, "sp", set.sp)

		vim.cmd(table.concat(cmd, " "))
	end
end

return M
