# echo "Installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ ! -d "$HOME/.config" ]; then
    echo "creating .config directory..."
    mkdir "$HOME/.config"
fi

echo "Installing Github CLI..."
brew install gh

echo "Installing Alacritty..."
brew install --cask alacritty

echo "Installing Neovim..."
brew install --HEAD neovim

echo "Installing packages required for neovim plugins to work correctly..."
brew install chafa imagemagick ghostscript ffmpeg ffmpegthumbnailer
brew install xcode-build-server xcbeautify jq rg ruby pipx
brew install stylua swiftformat shfmt
brew install TheZoraiz/ascii-image-converter/ascii-image-converter

cd ~/.local/share/nvim/lazy/xcodebuild.nvim || make install

echo "Installing tmux..."
brew install tmux

echo "Installing tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

echo "Installing tmux required tmux packages..."
brew install urlview

echo "Installing Postman..."
brew install --cask postman

echo "Installing Orbstack (docker client)..."
brew install --cask orbstack

echo "Installing fly cli (flyctl)..."
brew install flyctl

echo "Installing Aerospace..."
brew install --cask nikitabobko/tap/aerospace

echo "Installing borders..."
brew tap FelixKratz/formulae
brew install borders

echo "Installing Obsidian..."
brew install --cask obsidian

echo "Installing Commitizen..."
brew install commitizen

echo "Installing JavaScript..."
brew install node npm

echo "Installing zsh-autocomplete..."
brew install zsh-autocomplete

echo "Installing zsh-autosuggestions..."
brew install zsh-autosuggestions

echo "Installing zsh-syntax-highlighting..."
brew install zsh-syntax-highlighting

echo "Installing zoxide (better cd)..."
brew install zoxide

echo "Installing eza (better ls)..."
brew install eza

echo "Installing terminal utilities..."
brew install ripgrep fzf fd

echo "Installing Lazygit..."
brew install jesseduffield/lazygit/lazygit

echo "Installing Raycast..."
brew install --cask raycast

echo "Installing useful cli tools..."
brew install fastfetch tokei vapor postgresql

echo "Installing Ubersicht..."
brew install --cask ubersicht

echo "Moving tmux config to config..."
rm -rf "$HOME/.config/tmux"
ln -s "$PWD/tmux/" "$HOME/.config/tmux"

echo "Moving sourcekit-lsp config to config..."
rm -rf "$HOME/.sourcekit-lsp"
ln -s "$PWD/sourcekit-lsp/" "$HOME/.sourcekit-lsp"

echo "Moving wallpapers to config..."
rm -rf "$HOME/.config/wallpapers"
ln -s "$PWD/wallpapers/" "$HOME/.config/wallpapers"

echo "Moving images to config..."
rm -rf "$HOME/.config/images"
ln -s "$PWD/images/" "$HOME/.config/images"

echo "Moving scripts to config..."
rm -rf "$HOME/.config/scripts"
ln -s "$PWD/scripts/" "$HOME/.config/scripts"

echo "Moving automator scripts to config..."
rm -rf "$HOME/.config/automator"
ln -s "$PWD/automator/" "$HOME/.config/automator"

echo "Moving nvim config to config..."
rm -rf "$HOME/.config/nvim"
ln -s "$PWD/nvim/" "$HOME/.config/nvim"

echo "Moving gitconfig config to home..."
rm -rf "$HOME/.gitconfig"
ln -s "$PWD/gitconfig" "$HOME/.gitconfig"

echo "Moving Alacritty config to config..."
rm -rf "$HOME/.config/alacritty"
ln -s "$PWD/alacritty/" "$HOME/.config/alacritty"

echo "Moving Aerospace config to config..."
rm -rf "$HOME/.config/aerospace"
ln -s "$PWD/aerospace/" "$HOME/.config/aerospace"

echo "Moving Borders config to config..."
rm -rf "$HOME/.config/borders"
ln -s "$PWD/borders/" "$HOME/.config/borders"

echo "Moving Lazygit config to config..."
rm -rf "$HOME/Library/Application\ Support/lazygit"
ln -s "$PWD/lazygit/" "$HOME/Library/Application\ Support/lazygit"

echo "Moving zshrc config to home..."
rm -rf "$HOME/.zshrc"
ln -s "$PWD/zshrc" "$HOME/.zshrc"

echo "Moving shell prompt config to home..."
rm -rf "$HOME/.p10k.zsh"
ln -s "$PWD/p10k.zsh" "$HOME/.p10k.zsh"

echo "Moving vimrc config to home..."
rm -rf "$HOME/.vimrc"
ln -s "$PWD/vimrc" "$HOME/.vimrc"

echo "Sym linking icloud to HOME..."
ln -s "$HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/" "$HOME/icloud"

echo "Installing nerd font..."
brew install font-meslo-lg-nerd-font

echo "Installing Oh My ZSH..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing powerleve10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "Moving keyboard layout to input sources..."
sudo rm /Library/Keyboard\ Layouts/dvorak_prog_improved.keylayout
sudo cp ./keyboard/dvorak_prog_improved.keylayout /Library/Keyboard\ Layouts

echo "Authenticating with Github CLI..."
gh auth login
