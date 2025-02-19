--[[
MIT License

Copyright © hisasann (Yoshiyuki Hisamatsu)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local options = {
	encoding = "utf-8",
	fileencoding = "utf-8",
	title = true,
	backup = false,
	cmdheight = 2,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	hlsearch = true,
	ignorecase = true,
	mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	undofile = true,
	updatetime = 300,
	writebackup = false,
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	cursorline = true,
	number = true,
	relativenumber = false,
	numberwidth = 4,
	signcolumn = "yes",
	wrap = false,
	winblend = 0,
	wildoptions = "pum",
	pumblend = 5,
	background = "dark",
	scrolloff = 8,
	sidescrolloff = 8,
	splitbelow = false,
	splitright = false,
	clipboard = "unnamedplus",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

function set_filetype_settings()
	local filetype = vim.bo.filetype

	if filetype == "ps1" then
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
	elseif filetype == "sshconfig" then
		vim.opt.tabstop = 4
		vim.opt.shiftwidth = 4
	end
end

vim.api.nvim_command("autocmd FileType * lua set_filetype_settings()")

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]])
