---@diagnostic disable: undefined-global

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-s>", ":wa<Enter>")
vim.keymap.set("i", "<C-s>", "<Esc>:wa<Enter>")
vim.keymap.set("n", "<Esc>", ":wa<Enter>")
vim.keymap.set("i", "<Esc>", "<Esc>:wa<Enter>")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "H", "20zh")
vim.keymap.set("n", "L", "20zl")
vim.keymap.set("n", "J", "20zH")

vim.keymap.set("n", "gc", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

-- Add remap for neorg lists
vim.keymap.set("n", "<leader>l", "yypwwwc$")

-- Add remap for toggling nvimtree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<Enter>")
vim.api.nvim_set_keymap("n", ":", "<cmd>FineCmdline<CR>", { noremap = true })

-- Add remap for toggling line wrap
vim.api.nvim_set_keymap("n", "<leader>z", ":lua ToggleWrap()<CR>", { noremap = true, silent = true })

-- Add remap for formatting blade files
vim.api.nvim_set_keymap("n", "<leader>f", ":!blade-formatter '%' --write<CR><Enter>", { noremap = true, silent = true })

-- Add remap for toggling DBUI on and off
vim.api.nvim_set_keymap("n", "<leader>d", ":DBUIToggle<Enter>", { noremap = true })

-- Add remaps for moving line up and down with alt+k and alt+j
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })

vim.api.nvim_set_keymap("x", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<F5>", ":LspRestart<Enter>", { noremap = true, silent = true })

-- Add remap for multicursor mode
vim.api.nvim_set_keymap("n", "<C-y>", ":MCstart<Enter>", { noremap = true, silent = true })

-- Add remap for generating DOCblocks
vim.api.nvim_set_keymap("n", "<C-g>", ":Neogen<Enter>", { noremap = true, silent = true })

function ToggleWrap()
	if vim.wo.wrap == true then
		vim.wo.wrap = false
	else
		vim.wo.wrap = true
	end
end
