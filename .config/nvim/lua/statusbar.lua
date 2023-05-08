local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local colors = {
	bg = "#282A36",
	fd = "#F8F8F2",
	black = "#282A36",
	skyblue = "#6272A4",
	cyan = "#8BE9FD",
	green = "#50FA7B",
	oceanblue = "#44475A",
	magenta = "#FF79C6",
	orange = "#FFB86C",
	red = "#FF5555",
	violet = "#BD93F9",
	white = "F8F8F2",
	yellow = "#F1FA8C",
}

local vi_mode_colors = {
	NORMAL = colors.green,
	INSERT = colors.red,
	VISUAL = colors.pink,
	OP = colors.green,
	BLOCK = colors.cyan,
	REPLACE = colors.violet,
	["V-REPLACE"] = colors.violet,
	ENTER = colors.cyan,
	MORE = colors.cyan,
	SELECT = colors.orange,
	COMMAND = colors.green,
	SHELL = colors.green,
	TERM = colors.green,
	NONE = colors.yellow,
}

local icons = {
	linux = " ",
	macos = " ",
	windows = " ",
	lsp = " ",
	git = " ",
}

local function file_osinfo()
	local os = vim.bo.fileformat:upper()
	local icon
	if os == "UNIX" then
		icon = icons.linux
	elseif os == "MAC" then
		icon = icons.macos
	else
		icon = icons.windows
	end
	return icon .. os
end

function file_name ()
	return vim.fn.expand("%")
end

local comps = {
	vi_mode = {
		provider = "",
		hl = function()
			local val = {}
			val.fg = vi_mode_utils.get_mode_color()
			val.bg = colors.bg
			val.style = "bold"
			return val
		end,
		right_sep = "vertical_bar_thin",
	},
	file = {
		info = {
			provider = file_name,
			hl = {
				fg = colors.cyan,
				style = "bold",
			},
		},
		encoding = {
			provider = "file_encoding",
			left_sep = " ",
			hl = {
				fg = colors.violet,
				style = "bold",
			},
		},
		type = {
			provider = "file_type",
		},
		os = {
			provider = file_osinfo,
			left_sep = " ",
			hl = {
				fg = colors.violet,
				style = "bold",
			},
		},
	},
	line_percentage = {
		provider = "line_percentage",
		left_sep = " ",
		hl = {
			style = "bold",
		},
	},
	scroll_bar = {
		provider = "scroll_bar",
		left_sep = " ",
		hl = {
			fg = colors.cyan,
			style = "bold",
		},
	},
	diagnos = {
		err = {
			provider = "diagnostic_errors",
			left_sep = " ",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
			end,
			hl = {
				fg = colors.red,
				style = "bold",
			},
		},
		warn = {
			provider = "diagnostic_warnings",
			left_sep = " ",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
			end,
			hl = {
				fg = colors.yellow,
				style = "bold",
			},
		},
		info = {
			provider = "diagnostic_info",
			left_sep = " ",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
			end,
			hl = {
				fg = colors.cyan,
				style = "bold",
			},
		},
		hint = {
			provider = "diagnostic_hints",
			left_sep = " ",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.HINTS)
			end,
			hl = {
				fg = colors.cyan,
				style = "bold",
			},
		},
	},
	lsp = {
		name = {
			provider = "lsp_client_names",
			left_sep = " ",
			icon = icons.lsp,
			hl = {
				fg = colors.violet,
			},
		},
	},
	git = {
		branch = {
			provider = "git_branch",
			icon = icons.git,
			left_sep = " ",
			hl = {
				fg = colors.cyan,
				style = "bold",
			},
		},
		add = {
			provider = "git_diff_added",
			hl = {
				fg = colors.green,
			},
		},
		change = {
			provider = "git_diff_changed",
			hl = {
				fg = colors.orange,
			},
		},
		remove = {
			provider = "git_diff_removed",
			hl = {
				fg = colors.red,
			},
		},
	},
}

local properties = {
	force_inactive = {
		filetypes = {
			"NvimTree",
			"dbui",
			"packer",
			"startify",
			"fugitive",
			"fugitiveblame",
		},
		buftypes = { "terminal" },
		bufnames = {},
	},
}

local components = {
	active = {
		{
			comps.vi_mode,
			comps.file.info,
			comps.lsp.name,
			comps.diagnos.err,
			comps.diagnos.warn,
			comps.diagnos.info,
			comps.diagnos.hint,
		},
		{},
		{
			comps.file.os,
			comps.git.branch,
			comps.git.add,
			comps.git.change,
			comps.git.remove,
			comps.line_percentage,
		},
	},
	inactive = {
		{
			comps.vi_mode,
			comps.file.info,
		},
		{},
		{},
	},
}
local feline = require("feline")
feline.setup({
	default_bg = colors.bg,
	default_fg = colors.fd,
	components = components,
	properties = properties,
	vi_mode_colors = vi_mode_colors,
	theme = colors,
})
