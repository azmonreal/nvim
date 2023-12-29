# General
- fix wrong root dir detection for config
- improve file system stuff
    + file creation
    + dir navigation
- better keymas for basics
    - file saving
    - git stuff
- highlight yank pre(?post)view
- netrw
- buffer/window/split management
# LSP
- add default on_attach function for common keymaps
# Plugins
- standardize config location
    - when to use separate file, when to do in plugin spec
    - split config file
- related keymaps set in config function
- treesitter integration
    - solve 'matchit' incompatibility
        * at least for the rust parser, parentheses and braces are not escaped inside strings
    - text object motions
- snippets and completion
    - get snippets
    - better keympas for accepting completion
    - integrate snippets with cmp
    ? checkout 'coq' or which ever is the state of the art completion plugin
? autopairs
- telescope
    - customize picker appearance
    - setup keymaps
        + history
        + preview scroll
