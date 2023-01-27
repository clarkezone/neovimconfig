rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
mkdir ~/.config/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\n ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone --depth 1 https://github.com/clarkezone/neovimconfig.git\n ~/.config/nvim
