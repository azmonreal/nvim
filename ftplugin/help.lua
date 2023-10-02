local opts = { noremap = true, silent = true, buffer = true }

vim.keymap.set({ "" }, "<Esc>", "<cmd>q<CR>", opts);

vim.api.nvim_create_autocmd("BufWinEnter", { buffer = 0, command = "wincmd L" })
