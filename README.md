# neovimconfig

## Requirements

- Neovim >= 0.11

## Installation

### Linux / macOS

```bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone https://github.com/clarkezone/neovimconfig.git ~/.config/nvim
```

### Windows (PowerShell)

```powershell
Remove-Item -Recurse -Force ~\AppData\Local\nvim -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force ~\AppData\Local\nvim-data -ErrorAction SilentlyContinue
git clone https://github.com/clarkezone/neovimconfig.git ~\AppData\Local\nvim
```

On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) will bootstrap itself and install all plugins automatically. Run `:Lazy sync` to ensure everything is up to date.
