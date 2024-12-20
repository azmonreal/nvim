local cmp = require("cmp")
local sources = cmp.get_config().sources
table.insert(sources, { name = "vim-dadbod-completion" })
cmp.setup.buffer({ sources = sources })
