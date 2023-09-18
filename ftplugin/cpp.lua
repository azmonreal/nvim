vim.keymap.set({"n"}, "<F5>", function() vim.cmd.write() vim.cmd.make() end, {buffer = true})
