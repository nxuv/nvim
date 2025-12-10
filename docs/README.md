# Why are you here?

Welcome to this shitshow of config that I try to starve on everything I possibly can until it becomes 100 lines long.

Old fancy things? Trying to be cool hip distro? Naye, never heard of them.

Anyway better go to [one of other places](#other-places).

## File structure
```
├── after
│   ├── ftdetect - detects filetypes, see also plugin/shebang.lua
│   ├── ftplugin - adjusts settings per filetypes
│   ├── indent   - fixes awful vim autoindent
│   ├── plugin   - (external) plugin configs or things that immitate them
│   └── syntax   - syntax.
├── colors       - colorschemes, don't care about most of them
├── docs         - <<<<<< you are here >>>>>>
├── lua          - not a plugin stuff
└── plugin       - something that i either consider
                   worthy of being of plugin or want to autoload
```

## Requirements (in parens - package names, unless same)

Pluginless:
- rg (ripgrep)

Pluginlessless (TODO: %gork is this true?):
- aplay (alsa-utils)
- cc (any c compiler)
- curl
- fd
- fzf
- git
- gzip
- node (nodejs)
- rg (ripgrep)
- tar
- tree-sitter (npm install -g tree-sitter-cli)
- unzip

TODO: remove dependency check from lua/theme.lua
TODO: remove cringe
TODO: starve it even more

## Other Places
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)
- [CosmicNvim](https://github.com/CosmicNvim/CosmicNvim)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [NvChad](https://github.com/NvChad/NvChad)
- [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)
- [CyberNvim](https://github.com/pgosar/CyberNvim)
