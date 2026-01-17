-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.neovide then
	-- Set the GUI font (size 20, no hinting to avoid bold look)
	vim.o.guifont = "Hack Nerd Font:h20:#h-none"

	-- Allow ⌘ (Command) to be used as a modifier
	vim.g.neovide_input_use_logo = true

	-- Key mappings for macOS-style paste/copy
	-- vim.keymap.set("n", "<D-v>", '"+p', { noremap = true, silent = true }) -- Paste in normal mode
	-- vim.keymap.set("i", "<D-v>", "<C-r>+", { noremap = true, silent = true }) -- Paste in insert mode
	-- vim.keymap.set("c", "<D-v>", "<C-r>+", { noremap = true, silent = true }) -- Paste in command-line mode
	-- vim.keymap.set("v", "<D-c>", '"+y', { noremap = true, silent = true }) -- Copy in visual mode

	-- Paste in normal mode
	vim.api.nvim_set_keymap("n", "<D-v>", '"+]p', { noremap = true, silent = true })
	-- Paste in insert mode
	vim.api.nvim_set_keymap("i", "<D-v>", "<C-r>+", { noremap = true, silent = true })
	-- Paste in command-line mode
	vim.api.nvim_set_keymap("c", "<D-v>", "<C-r>+", { noremap = true, silent = true })
	-- Paste in visual mode
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-r>+", { noremap = true, silent = true })
	-- Paste in terminal mode
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-r>+", { noremap = true, silent = true })

	-- Opacity of the window (0.0 = fully transparent, 1.0 = fully opaque)
	vim.g.neovide_opacity = 0.88

	-- Extra space between lines (helps readability)
	vim.opt.linespace = 14

	-- UI scaling (1.0 = default; similar to iTerm)
	vim.g.neovide_scale_factor = 1.0

	-- Remove bold styling in normal text
	vim.api.nvim_set_hl(0, "Normal", { bold = false })

	-- Disable scroll animation for instant scrolling
	vim.g.neovide_scroll_animation_length = 0.3

	-- Cursor animation speed (0.05 = smooth but fast)
	vim.g.neovide_cursor_animation_length = 0.05

	-- vim.g.neovide_scroll_animation_far_lines = 1

	-- Cursor visual effects (try "railgun", "torpedo", etc.)
	vim.g.neovide_cursor_vfx_mode = "sonicboom"
	vim.g.neovide_cursor_vfx_opacity = 200
	vim.g.neovide_cursor_vfx_mode_blend_mode = "Rgb"

	-- Ask for confirmation before quitting (⌘Q)
	vim.g.neovide_confirm_quit = true

	-- Use faster render mode (reduces visual quality slightly)
	vim.g.neovide_render_options = "vsync,blending"

	-- Frame refresh rate (in Hz)
	vim.g.neovide_refresh_rate = 120

	-- Lower refresh rate when idle (to save CPU/GPU)
	vim.g.neovide_refresh_rate_idle = 5

	-- Allow Neovide to enter idle mode
	vim.g.neovide_no_idle = false

	vim.g.neovide_no_border = true
end
