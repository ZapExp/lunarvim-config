--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
	"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd([[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]])

-- Set a compatible clipboard manager
vim.g.clipboard = {
	copy = {
		["+"] = "win32yank.exe -i --crlf",
		["*"] = "win32yank.exe -i --crlf",
	},
	paste = {
		["+"] = "win32yank.exe -o --lf",
		["*"] = "win32yank.exe -o --lf",
	},
}

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.wo.wrap = true

vim.opt.scrolloff = 8
vim.opt.colorcolumn = "80"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
	enabled = true,
	pattern = "*.lua",
	timeout = 1000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

lvim.keys.insert_mode["<C-b>"] = "<ESC>^i"
lvim.keys.insert_mode["<C-e>"] = "<End>"

lvim.keys.insert_mode["<C-h>"] = "<Left>"
lvim.keys.insert_mode["<C-l>"] = "<Right>"
-- lvim.keys.insert_mode["<C-j>"] = "<Down>"
-- lvim.keys.insert_mode["<C-k>"] = "<Up>"
lvim.keys.insert_mode["<C-s>"] = "<esc>:w<cr>a"

lvim.keys.normal_mode["<C-u>"] = { "<C-u>zz0", { silent = true } }
lvim.keys.normal_mode["<C-d>"] = { "<C-d>zz0", { silent = true } }
lvim.keys.normal_mode["{"] = { "{zz0", { silent = true } }
lvim.keys.normal_mode["}"] = { "}zz0", { silent = true } }
lvim.keys.normal_mode["n"] = { "nzzzv", { silent = true } }
lvim.keys.normal_mode["N"] = { "Nzzzv", { silent = true } }
lvim.keys.normal_mode["<Esc>"] = { ":noh<CR>", { silent = true } }

lvim.keys.normal_mode["J"] = { "mzJ`z", { silent = true } }

lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["ñ"] = ":HopWord<CR>"
lvim.keys.normal_mode["Ñ"] = ":HopLine<CR>"

-- -- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.which_key.mappings["r"] =
	{ [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Replace current word" }

lvim.builtin.which_key.mappings["h"] = {
	name = "Harpoon",
	a = {
		function()
			require("harpoon.mark").add_file()
		end,
		"Add file to Harpoon",
	},
	t = {
		function()
			require("harpoon.ui").toggle_quick_menu()
		end,
		"Toggle quick menu",
	},
	f = {
		function()
			require("harpoon.ui").nav_file(1)
		end,
		"Go to file 1",
	},
	g = {
		function()
			require("harpoon.ui").nav_file(2)
		end,
		"Go to file 2",
	},
	h = {
		function()
			require("harpoon.ui").nav_file(3)
		end,
		"Go to file 3",
	},
	j = {
		function()
			require("harpoon.ui").nav_file(4)
		end,
		"Go to file 4",
	},
	n = {
		function()
			require("harpoon.ui").nav_next()
		end,
		"Go to next file",
	},
	p = {
		function()
			require("harpoon.ui").nav_prev()
		end,
		"Go to previous file",
	},
}

-- -- Change theme settings
lvim.colorscheme = "catppuccin-macchiato"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- ensure these parsers are always installed, useful for those without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "azure-pipelines-language-server" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

require("lvim.lsp.manager").setup("emmet_ls", {
	filetypes = {
		"css",
		"eruby",
		"html",
		-- "javascript",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"svelte",
		"pug",
		"typescriptreact",
		"vue",
	},
	init_options = {
		html = {
			options = {
				-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
				["bem.enabled"] = true,
			},
		},
	},
})

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
-- 	return server ~= "emmet-ls"
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
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "prettierd",
		extra_args = { "--single-attribute-per-line" },
	},
})
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
	--     {
	--       "folke/trouble.nvim",
	--       cmd = "TroubleToggle",
	--     },
	{
		"catppuccin/nvim",
		name = "catppuccin",
	},
	{
		"echasnovski/mini.surround",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.surround").setup()
		end,
	},
	{
		"ThePrimeagen/harpoon",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			-- require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			require("hop").setup({ keys = "asdfghjklñ" })
		end,
	},
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree" },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				-- defaults
				"vim",
				"lua",

				-- web dev
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"svelte",
			},
		},
	},
	-- {
	-- 	"NvChad/nvim-colorizer.lua",
	-- 	opts = {
	-- 		user_default_options = {
	-- 			tailwind = true,
	-- 		},
	-- 	},
	-- },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	event = "InsertEnter",
	-- 	dependencies = { "zbirenbaum/copilot.lua" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup({
	-- 				panel = {
	-- 					enabled = false,
	-- 					-- auto_refresh = false,
	-- 					-- keymap = {
	-- 					-- 	jump_next = "<c-j>",
	-- 					-- 	jump_prev = "<c-k>",
	-- 					-- 	accept = "<c-m>",
	-- 					-- 	refresh = "r",
	-- 					-- 	open = "<M-CR>",
	-- 					-- },
	-- 					-- layout = {
	-- 					-- 	position = "bottom", -- | top | left | right
	-- 					-- 	ratio = 0.4,
	-- 					-- },
	-- 				},
	-- 				suggestion = {
	-- 					enabled = true,
	-- 					auto_trigger = true,
	-- 					debounce = 75,
	-- 					keymap = {
	-- 						accept = "<c-m>",
	-- 						accept_word = false,
	-- 						accept_line = false,
	-- 						next = "<C-j>",
	-- 						prev = "<C-k>",
	-- 						dismiss = false,
	-- 					},
	-- 				},
	-- 			})
	-- 			-- require("copilot_cmp").setup()
	-- 		end, 100)
	-- 	end,
	-- },
}

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- lvim.autocommands = {
-- 	{
-- 		{ "ColorScheme" },
-- 		{
-- 			pattern = "*",
-- 			callback = function()
-- 				-- change `Normal` to the group you want to change
-- 				-- and `#ffffff` to the color you want
-- 				-- see `:h nvim_set_hl` for more options
-- 				vim.api.nvim_set_hl(0, "@parameter", { fg = "#ed8796", underline = false })
-- 				vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { fg = "#c6a0f6", underline = false })
-- 			end,
-- 		},
-- 	},
-- }
