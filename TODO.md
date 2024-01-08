# General
- netrw
- improve file system stuff
    + file creation
    + dir navigation
- better keymas for basics
    - file saving
    - git stuff
- buffer/window/split management
- mappings for closing/quitting 'special' buffers
    - smarter behavior
        * dont close if only split in window
        * close split
# Plugins
- related keymaps set in config function
- treesitter integration
    - solve 'matchit' incompatibility
        * at least for the rust parser, parentheses and braces are not escaped inside strings
    - text object motions
- snippets and completion
    - get snippets
    - better keympas for accepting completion
    - improve cmp window highlights (nvchad as reference https://github.com/fitrh/init.nvim/blob/main/lua/config/plugin/cmp/setup.lua#L39-L56)
    ? checkout 'coq' or which ever is the state of the art completion plugin
? autopairs
- telescope
    - customize picker appearance
    - setup keymaps
        + history
        + preview scroll
- statuscolumn
    - fix ufo
- dap
    - keymaps
    - ui improvements
        * fix debug repl size increase
        * customize layout
